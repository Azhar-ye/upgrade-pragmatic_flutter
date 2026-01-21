import 'package:flutter/material.dart';
import 'themes.dart';

//void main() => runApp(const BooksApp());

/// Chapter10: Local theme demonstration
class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: defaultTheme,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
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

    // Local theme only for this widget tree
    final localTheme = Theme.of(context).copyWith(
      cardTheme: const CardThemeData(
        color: Colors.pinkAccent,
      ),
      textTheme: Theme.of(context).textTheme.copyWith(
            titleLarge: const TextStyle(
              fontFamily: 'Pangolin',
              fontSize: 20,
            ),
            bodyMedium: const TextStyle(
              fontStyle: FontStyle.italic,
            ),
          ),
    );

    return Theme(
      data: localTheme,
      child: ListView.builder(
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
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        (book['authors'] != null &&
                                (book['authors'] as List).isNotEmpty)
                            ? Text(
                                'Author(s): ${(book['authors'] as List).join(", ")}',
                                style: Theme.of(context).textTheme.bodyMedium,
                              )
                            : const Text(""),
                      ],
                    ),
                  ),
                  Image.asset(
                    book['image'],
                    width: 60,
                    height: 80,
                    fit: BoxFit.fill,
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
