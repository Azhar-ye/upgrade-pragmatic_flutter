import 'package:flutter/material.dart';

//void main() => runApp(const BooksApp());

/// Chapter09: Building User Interface for BooksApp
class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text("Books Listing"),
        ),
        body: const BooksListing(),
      ),
    );
  }
}

List<Map<String, dynamic>> bookData() {
  return [
    {
      'title': 'Book Title',
      'authors': ['Author1', 'Author2'],
      'image': 'assets/book_cover.png',
    },
    {
      'title': 'Book Title 2',
      'authors': ['Author1'],
      'image': 'assets/book_cover.png',
    },
  ];
}

class BooksListing extends StatelessWidget {
  const BooksListing({super.key});

  @override
  Widget build(BuildContext context) {
    final booksListing = bookData();

    return ListView.builder(
      itemCount: booksListing.length,
      itemBuilder: (context, index) {
        final book = booksListing[index];

        return Card(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
          elevation: 5,
          margin: const EdgeInsets.all(10),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(
                        '${book['title']}',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      (book['authors'] != null &&
                              (book['authors'] as List).isNotEmpty)
                          ? Text(
                              'Author(s): ${(book['authors'] as List).join(", ")}',
                              style: const TextStyle(fontSize: 14),
                            )
                          : const Text(""),
                    ],
                  ),
                ),
                (book['image'] != null)
                    ? Image.asset(
                        book['image'],
                        width: 60,
                        height: 80,
                        fit: BoxFit.fill,
                      )
                    : Container(),
              ],
            ),
          ),
        );
      },
    );
  }
}
