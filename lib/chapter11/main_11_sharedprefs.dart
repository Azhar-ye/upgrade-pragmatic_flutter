// Persisting selected theme using SharedPreferences (Flutter terbaru FIX)
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'themes.dart';

void main() => runApp(const BooksApp());

enum AppThemes { light, dark }

class BooksApp extends StatefulWidget {
  const BooksApp({super.key});

  @override
  State<BooksApp> createState() => _BooksAppState();
}

class _BooksAppState extends State<BooksApp> {
  AppThemes currentTheme = AppThemes.light;

  @override
  void initState() {
    super.initState();
    loadActiveTheme();
  }

  // Load theme from SharedPreferences
  Future<void> loadActiveTheme() async {
    final sharedPrefs = await SharedPreferences.getInstance();
    final themeId = sharedPrefs.getInt('theme_id') ?? AppThemes.light.index;

    setState(() {
      currentTheme = AppThemes.values[themeId];
    });
  }

  // Switch theme and save to SharedPreferences
  Future<void> switchTheme() async {
    final newTheme =
        currentTheme == AppThemes.light ? AppThemes.dark : AppThemes.light;

    final sharedPrefs = await SharedPreferences.getInstance();
    await sharedPrefs.setInt('theme_id', newTheme.index);

    setState(() {
      currentTheme = newTheme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: currentTheme == AppThemes.light ? defaultTheme : darkTheme,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: () async {
                await switchTheme();
              },
            ),
          ],
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
    );
  }
}
