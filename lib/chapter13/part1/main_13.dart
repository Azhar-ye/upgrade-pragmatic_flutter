import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'booktile.dart';

//void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksListing(),
    );
  }
}

class BooksListing extends StatefulWidget {
  const BooksListing({super.key});

  @override
  State<BooksListing> createState() => _BooksListingState();
}

class _BooksListingState extends State<BooksListing> {
  List<dynamic> books = [];
  bool isLoading = true;

  Future<void> fetchBooks() async {
    const apiEndpoint =
        "https://www.googleapis.com/books/v1/volumes?q=python+coding";

    final response = await http.get(Uri.parse(apiEndpoint));

    if (response.statusCode == 200) {
      final decoded = jsonDecode(response.body);
      setState(() {
        books = decoded['items'] ?? [];
        isLoading = false;
      });
    } else {
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapter 13 - Part 1"),
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : ListView.builder(
              itemCount: books.length,
              itemBuilder: (context, index) {
                return BookTile(book: books[index]);
              },
            ),
    );
  }
}
