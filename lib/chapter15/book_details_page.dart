import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import 'book.dart';

class BookDetailsPage extends StatelessWidget {
  final BookModel book;

  const BookDetailsPage({super.key, required this.book});

  Future<void> openUrl(String url) async {
    final uri = Uri.parse(url);

    if (!await launchUrl(uri, mode: LaunchMode.externalApplication)) {
      throw Exception("Gagal membuka link: $url");
    }
  }

  @override
  Widget build(BuildContext context) {
    final title = book.volumeInfo?.title ?? "-";
    final authors = (book.volumeInfo?.authors ?? []).join(", ");
    final desc = book.volumeInfo?.description ?? "No description";

    final webReader = book.accessInfo?.webReaderLink;
    final buyLink = book.saleInfo?.buyLink;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: ListView(
            children: [
              Text(
                title,
                style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text("Author(s): $authors"),
              const SizedBox(height: 16),

              // Buttons
              Row(
                children: [
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: webReader == null
                          ? null
                          : () async {
                              await openUrl(webReader);
                            },
                      icon: const Icon(Icons.chrome_reader_mode),
                      label: const Text("Read"),
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: ElevatedButton.icon(
                      onPressed: buyLink == null
                          ? null
                          : () async {
                              await openUrl(buyLink);
                            },
                      icon: const Icon(Icons.shopping_cart),
                      label: const Text("Buy"),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),
              const Text(
                "Description",
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 8),
              Text(desc),
            ],
          ),
        ),
      ),
    );
  }
}
