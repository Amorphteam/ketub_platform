import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/main/library_tab/cubit/library_all_books_cubit.dart';
import 'package:ketub_platform/screens/main/library_tab/cubit/library_all_books_state.dart';
import 'package:ketub_platform/screens/main/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

import '../bookmark_tab/bookmark_screen.dart';
import '../bookmark_tab/cubit/bookmark_cubit.dart';
import '../shared_widgets/search_bar_widget.dart';

class LibraryAllBooksScreen extends StatefulWidget {
  const LibraryAllBooksScreen({Key? key}) : super(key: key);

  @override
  State<LibraryAllBooksScreen> createState() => _LibraryAllBooksScreenState();
}

class _LibraryAllBooksScreenState extends State<LibraryAllBooksScreen> {
  List<CategoryModel> cats = [];
  List<BookModel> books = [];
  int bookmarkCount = 0;

  @override
  void initState() {
    super.initState();
    _loadAllBooks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<LibraryAllBooksCubit, LibraryAllBooksState>(
      listener: (context, state) {
        state.maybeWhen(
          bookClicked: (cats, id, bookName) => _openEpub(cats, id, bookName),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return state.when(
          init: () => const Center(child: CircularProgressIndicator()),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (error) => Center(child: Text('Error: $error')),
          allBooksLoaded: (books, cats) {
            _loadAllBookmarksCount();
            return _buildAllBooks(books, cats);
          },
          filteredBooksLoaded: (filteredBooks, cats) =>
              _buildAllBooks(filteredBooks, cats),
          bookClicked: (cats, id, bookName) => _buildAllBooks(books, this.cats),
          allBookmarksCountLoaded: (count) {
            bookmarkCount = count;
            return _buildAllBooks(books, cats);
          },
        );
      },
    );
  }

  void _loadAllBooks() {
    context.read<LibraryAllBooksCubit>().loadAllBooks();
  }

  _openEpub(List<CategoryModel> cats, int id, String bookName) {
    if (cats.length == 1) {
      openEpub(context: context, cat: cats.first);
    } else {
      showBooksDialog(bookName, cats);
    }
  }

  void showBooksDialog(String bookName, List<CategoryModel> cats) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            bookName,
            textAlign: TextAlign.center,
            style: TextStyle(overflow: TextOverflow.ellipsis, fontSize: 16),
            maxLines: 2, // Ensure text does not exceed more than 2 lines
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: cats.map((cat) {
              return ListTile(
                title: Text(
                  cat.bookName ?? '',
                  style: TextStyle(fontSize: 14),
                ),
                onTap: () {
                  openEpub(context: context, cat: cat);
                },
              );
            }).toList(),
          ),
        );
      },
    );
  }

  Widget _buildAllBooks(List<BookModel> books, List<CategoryModel> cats) {
    this.cats = cats;
    this.books = books;
    return Scaffold(
      body: Column(
        children: [
          Stack(
            alignment: Alignment.topCenter,
            children: [
              // Image widget
              Image.asset(
                'assets/images/nosos_bk_header.png',
                height: 200,
                fit: BoxFit.cover,
              ),
              Positioned(
                bottom: 0,
                child: Container(
                  margin: const EdgeInsets.only(bottom: 5),
                  width: MediaQuery.of(context).size.width - 40,
                  child: SearchBarWiget(
                    hint: 'ابحث عن كلمة أو جملة في كلا المجلتين',
                    onChanged: _filterBooks,
                  ),
                ),
              ),
            ],
          ),
          Expanded(
            child: ListView.builder(
              itemCount: 3, // Update the count to 3 for the three categories
              itemBuilder: (context, index) {
                // Initialize variables that will be modified based on the index
                late final List<BookModel> currentBookList;
                late final String logo;
                late final String title;

                // Assign the appropriate values based on the index
                if (index == 0) {
                  currentBookList = books;
                  logo = 'assets/images/ejtihad_logo.png';
                  title = 'الاجتهاد والتجديد';
                } else if (index == 1) {
                  // currentBookList = otherBooks; // Replace with your actual otherBooks list
                  logo = 'assets/images/nosos_logo.png';
                  title = 'نصوص معاصرة';
                } else if (index == 2) {
                  // currentBookList = additionalBooks; // Replace with your actual additionalBooks list
                  logo = 'assets/images/nosos_logo.png'; // Replace with your actual additional logo
                  title = 'كتب المجلة'; // Replace with your actual additional title
                }

                return BookListWidget(
                  bookList: books,
                  cubit: context.read<LibraryAllBooksCubit>(),
                  logo: logo,
                  title: title,
                );
              },
            ),
          ),

        ],
      ),
    );
  }

  _openBookmarkScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => BookmarkCubit(),
          child: BookmarkScreen(),
        ),
      ),
    );
  }

  void _loadAllBookmarksCount() {
    context.read<LibraryAllBooksCubit>().loadAllBookmarks();
  }

  void _filterBooks(String p1) {
    context.read<LibraryAllBooksCubit>().filterBooks(p1);
  }
}
