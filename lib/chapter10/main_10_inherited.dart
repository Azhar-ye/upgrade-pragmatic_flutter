/// Switching Themes using InheritedWidget (Flutter 최신 버전 FIX)
import 'package:flutter/material.dart';

import 'booklisting.dart';

//void main() => runApp(const BooksApp());

class BooksApp extends StatelessWidget {
  const BooksApp({super.key});

  @override
  Widget build(BuildContext context) {
    return RootWidget(
      child: BooksAppScreen(
        child: const BooksListing(),
      ),
    );
  }
}

class RootWidget extends StatefulWidget {
  final Widget child;

  const RootWidget({super.key, required this.child});

  static RootWidgetState of(BuildContext context) {
    final inherited =
        context.dependOnInheritedWidgetOfExactType<MyInheritedWidget>();
    return inherited!.data;
  }

  @override
  State<RootWidget> createState() => RootWidgetState();
}

class RootWidgetState extends State<RootWidget> {
  MyThemes _currentTheme = MyThemes.light;
  MyThemes get currentTheme => _currentTheme;

  void switchTheme() {
    setState(() {
      _currentTheme =
          _currentTheme == MyThemes.light ? MyThemes.dark : MyThemes.light;
    });
  }

  @override
  Widget build(BuildContext context) {
    return MyInheritedWidget(
      data: this,
      child: widget.child,
    );
  }
}

class MyInheritedWidget extends InheritedWidget {
  final RootWidgetState data;

  const MyInheritedWidget({
    super.key,
    required super.child,
    required this.data,
  });

  @override
  bool updateShouldNotify(covariant MyInheritedWidget oldWidget) {
    return true;
  }
}

class BooksAppScreen extends StatelessWidget {
  final Widget child;

  const BooksAppScreen({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    final isLight = RootWidget.of(context).currentTheme == MyThemes.light;

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: isLight ? themeData[0] : themeData[1],
      home: Scaffold(
        appBar: AppBar(
          leading: const Icon(Icons.home),
          title: const Text("Books Listing"),
          actions: [
            IconButton(
              icon: const Icon(Icons.all_inclusive),
              onPressed: () => RootWidget.of(context).switchTheme(),
            )
          ],
        ),
        body: child,
      ),
    );
  }
}

enum MyThemes { light, dark }

final List<ThemeData> themeData = [
  ThemeData(
    brightness: Brightness.light,
    colorScheme: ColorScheme.fromSeed(seedColor: Colors.blue),
    useMaterial3: true,
  ),
  ThemeData(
    brightness: Brightness.dark,
    colorScheme: ColorScheme.fromSeed(
      seedColor: Colors.orange,
      brightness: Brightness.dark,
    ),
    useMaterial3: true,
  ),
];
