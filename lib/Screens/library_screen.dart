import 'package:flutter/material.dart';
import 'package:ketub_platform/Screens/search_screen.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/utils/temp_data.dart';
import 'package:ketub_platform/widgets/book_list_widget.dart';

class LibraryScreen extends StatefulWidget {
  final List<BookModel> bookList;
  const LibraryScreen(this.bookList);

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(),
                ),
              );
            },
            child: InputDecorator(
              decoration: InputDecoration(
                contentPadding: EdgeInsets.zero,
                prefixIcon: Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: Text(
                'Search',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        Expanded(child: BookListWidget(bookList: widget.bookList)),
      ],
    );
  }
}
