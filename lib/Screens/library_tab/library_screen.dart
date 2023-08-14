import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/screens/search/search_screen.dart';
import 'package:ketub_platform/utils/temp_data.dart';

import 'cubit/library_cubit.dart';

class LibraryScreen extends StatefulWidget {
  const LibraryScreen();

  @override
  State<LibraryScreen> createState() => _LibraryScreenState();
}

class _LibraryScreenState extends State<LibraryScreen> {
  @override
  void initState() {
    super.initState();
    _fetchBooks();
  }

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
              child: const Text(
                'Search',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
        BlocBuilder<LibraryCubit, LibraryState>(
          builder: (context, state) {
            if (state is AllBookState) {
              return Flexible(child: BookListWidget(bookList: state.books));
            } else {
              return Flexible(child: BookListWidget(bookList: tempBook));
            }
          },
        ),
      ],
    );
  }

  void _fetchBooks() {
    BlocProvider.of<LibraryCubit>(context).fetchBooks();
  }
}
