import 'package:flutter/material.dart';

class BookTile extends StatelessWidget {
  final dynamic book;

  const BookTile({super.key, required this.book});

  @override
  Widget build(BuildContext context) {
    final volumeInfo = book['volumeInfo'] ?? {};
    final title = volumeInfo['title'] ?? 'No Title';
    final authors = volumeInfo['authors'] ?? [];
    final thumbnail =
        volumeInfo['imageLinks']?['thumbnail'];

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: Row(
          children: [
            if (thumbnail != null)
              Image.network(
                thumbnail,
                width: 60,
                height: 80,
                fit: BoxFit.cover,
              )
            else
              const SizedBox(
                width: 60,
                height: 80,
                child: Icon(Icons.book),
              ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 6),
                  Text(
                    authors.isNotEmpty
                        ? "Author(s): ${authors.join(", ")}"
                        : "Author(s): -",
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
