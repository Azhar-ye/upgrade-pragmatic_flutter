import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import '../config.dart';
import 'book.dart';
import 'book_details_page.dart';
import 'booktile.dart';

//void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BooksListingPage(),
    );
  }
}

class BooksListingPage extends StatefulWidget {
  const BooksListingPage({super.key});

  @override
  State<BooksListingPage> createState() => _BooksListingPageState();
}

class _BooksListingPageState extends State<BooksListingPage> {
  List<BookModel> booksListing = [];
  bool isLoading = true;
  String? errorMsg;

  Future<void> fetchBooks() async {
    try {
      final apiEndpoint =
          "https://www.googleapis.com/books/v1/volumes?key=$YOUR_API_KEY&q=python+coding&maxResults=20";

      final response = await http.get(Uri.parse(apiEndpoint));

      if (response.statusCode != 200) {
        throw Exception("HTTP ${response.statusCode}: ${response.body}");
      }

      final Map<String, dynamic> jsonData = jsonDecode(response.body);
      final List items = (jsonData['items'] ?? []) as List;

      final parsedBooks = items
          .map((item) => BookModel.fromJson(item as Map<String, dynamic>))
          .toList();

      setState(() {
        booksListing = parsedBooks;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        errorMsg = e.toString();
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    fetchBooks();
  }

  void openDetails(BookModel book) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => BookDetailsPage(book: book),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Chapter 15 - Read & Buy Link"),
      ),
      body: SafeArea(
        child: isLoading
            ? const Center(child: CircularProgressIndicator())
            : (errorMsg != null)
                ? Center(child: Text("Error: $errorMsg"))
                : ListView.builder(
                    itemCount: booksListing.length,
                    itemBuilder: (context, index) {
                      final book = booksListing[index];

                      return InkWell(
                        onTap: () => openDetails(book),
                        child: BookTile(bookModelObj: book),
                      );
                    },
                  ),
      ),
    );
  }
}
