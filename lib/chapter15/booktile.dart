import 'package:flutter/material.dart';

import 'book.dart';

class BookTile extends StatelessWidget {
  final BookModel bookModelObj;

  const BookTile({super.key, required this.bookModelObj});

  @override
  Widget build(BuildContext context) {
    final title = bookModelObj.volumeInfo?.title ?? "-";
    final authors = (bookModelObj.volumeInfo?.authors ?? []).join(", ");

    return Card(
      elevation: 4,
      margin: const EdgeInsets.all(10),
      child: ListTile(
        leading: const Icon(Icons.book),
        title: Text(title),
        subtitle: Text("Author(s): $authors"),
      ),
    );
  }
}
