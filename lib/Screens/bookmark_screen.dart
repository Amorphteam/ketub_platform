import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/cubits/bookmark_cubit.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/widgets/reference_list_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen();

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBookmarks();
  }

  void _add() {
    final bookmark = ReferenceModel(
      id: _generateUniqueId(),
      title: "Reference 2",
      bookName: "Book 2",
      bookPath: "path/to/book2.pdf",
      navIndex: "2",
      navUri: "nav2",
      scrollPercent: 0.8,
    );

    BlocProvider.of<BookmarkCubit>(context).addBookmark(bookmark);
    _update(context, bookmark);
  }

  int _generateUniqueId() {
    final random = Random();
    int id;
    do {
      id = random.nextInt(100); // Adjust the range as needed
    } while (_isIdExists(id));
    return id;
  }

  bool _isIdExists(int id) {
    // Check if the generated id already exists in the table
    final state = BlocProvider.of<BookmarkCubit>(context).state;
    return state.bookmarks.any((bookmark) => bookmark.id == id);
  }

  void _fetchBookmarks() {
    BlocProvider.of<BookmarkCubit>(context).fetchBookmarks();
  }

  void _update(BuildContext context, ReferenceModel bookmark) {
    BlocProvider.of<BookmarkCubit>(context).updateBookmark(bookmark);
  }

  void _filterList(String query) {
    BlocProvider.of<BookmarkCubit>(context).filterBookmarks(query);
  }

  // void _filterList(String query) {
  //   final state = BlocProvider.of<BookmarkCubit>(context).state;
  //   setState(() {
  //     state.bookmarks.where((item) {
  //     return item.title.toLowerCase().contains(query.toLowerCase());
  //     }).toList();
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            onChanged: (value) => _filterList(value),
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            return FloatingActionButton(
              onPressed: () {
                _add();
              },
              tooltip: 'Add',
              child: const Icon(Icons.add),
            );
          },
        ),
        BlocBuilder<BookmarkCubit, BookmarkState>(
          builder: (context, state) {
            return Flexible(
                child: ReferenceListWidget(referenceList: state.bookmarks));
          },
        ),
      ],
    );
  }
}
