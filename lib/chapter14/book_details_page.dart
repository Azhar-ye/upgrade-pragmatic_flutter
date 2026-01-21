import 'package:flutter/material.dart';
import 'book.dart';

class BookDetailsPage extends StatelessWidget {
  final BookModel book;

  const BookDetailsPage({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final title = book.volumeInfo?.title ?? "No Title";
    final subtitle = book.volumeInfo?.subtitle ?? "";
    final authors = book.volumeInfo?.authors ?? [];
    final description = book.volumeInfo?.description ?? "No Description";
    final thumbnail = book.volumeInfo?.imageLinks?.thumbnail;

    return Scaffold(
      appBar: AppBar(
        title: const Text("Book Details"),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            if (thumbnail != null && thumbnail.isNotEmpty)
              Center(
                child: Image.network(
                  thumbnail,
                  height: 200,
                  errorBuilder: (context, error, stackTrace) {
                    return const Icon(Icons.book, size: 120);
                  },
                ),
              )
            else
              const Center(child: Icon(Icons.book, size: 120)),
            const SizedBox(height: 16),

            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),

            if (subtitle.isNotEmpty) ...[
              const SizedBox(height: 6),
              Text(subtitle, style: const TextStyle(fontSize: 14)),
            ],

            const SizedBox(height: 10),
            Text(
              authors.isNotEmpty ? "Author(s): ${authors.join(", ")}" : "Author(s): -",
              style: const TextStyle(fontSize: 14),
            ),

            const SizedBox(height: 16),
            const Text(
              "Description",
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text(description),
          ],
        ),
      ),
    );
  }
}
