/// Switching Themes using Provider package (Flutter terbaru FIX)
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'booklisting.dart';
import 'themes_notifier.dart';

void main() {
  runApp(
    ChangeNotifierProvider<ThemesNotifier>(
      create: (BuildContext context) => ThemesNotifier(),
      child: const BooksApp(),
    ),
  );
}

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: context.watch<ThemesNotifier>().currentThemeData,
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: () => context.read<ThemesNotifier>().switchTheme(),
            )
          ],
        ),
        body: const BooksListing(),
      ),
    );
  }
}
