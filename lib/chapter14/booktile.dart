import 'package:flutter/material.dart';
import 'book.dart';
import 'book_details_page.dart';

class BookTile extends StatelessWidget {
  final BookModel bookModelObj;

  const BookTile({super.key, required this.bookModelObj});

  @override
  Widget build(BuildContext context) {
    final title = bookModelObj.volumeInfo?.title ?? "No Title";
    final authors = bookModelObj.volumeInfo?.authors ?? [];
    final thumbnail = bookModelObj.volumeInfo?.imageLinks?.thumbnail;

    return InkWell(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => BookDetailsPage(book: bookModelObj),
          ),
        );
      },
      child: Card(
        elevation: 4,
        margin: const EdgeInsets.all(10),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12),
        ),
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Row(
            children: [
              if (thumbnail != null && thumbnail.isNotEmpty)
                Image.network(
                  thumbnail,
                  width: 60,
                  height: 80,
                  fit: BoxFit.cover,
                  errorBuilder: (context, error, stackTrace) {
                    return const SizedBox(
                      width: 60,
                      height: 80,
                      child: Icon(Icons.book),
                    );
                  },
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
              const Icon(Icons.arrow_forward_ios, size: 16),
            ],
          ),
        ),
      ),
    );
  }
}
