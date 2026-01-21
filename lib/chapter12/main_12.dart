import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

/// Chapter12: Integrating REST API (Google Books API) - tanpa API Key
//void main() => runApp(const BooksApp());

// Making HTTP request
Future<String> makeHttpCall() async {
 
  
  final apiEndpoint =
      "https://www.googleapis.com/books/v1/volumes?q=python+coding";

  final http.Response response = await http.get(
    Uri.parse(apiEndpoint),
    headers: {'Accept': 'application/json'},
  );

  debugPrint("STATUS: ${response.statusCode}");
  return response.body;
}

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
  String? booksResponse;
  bool isLoading = true;

  Future<void> fetchBooks() async {
    try {
      final response = await makeHttpCall();
      setState(() {
        booksResponse = response;
        isLoading = false;
      });
    } catch (e) {
      setState(() {
        booksResponse = "ERROR: $e";
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
        title: const Text("Chapter 12 - REST API"),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(12),
          child: isLoading
              ? const Center(child: CircularProgressIndicator())
              : Text(booksResponse ?? "No Response from API"),
        ),
      ),
    );
  }
}
