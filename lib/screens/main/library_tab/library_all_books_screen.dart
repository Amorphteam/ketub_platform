import 'package:flutter/material.dart';
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
          filteredBooksLoaded: (filteredBooks, cats) => _buildAllBooks(filteredBooks, cats),
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
          ),          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: cats.map((cat) {
              return ListTile(
                title: Text(cat.bookName ?? '', style: TextStyle(fontSize: 14),),
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
      appBar: AppBar(
        title: Row(
          children: [
            Expanded(child: SearchBarWiget(hint: 'ابحث في الكتب', onChanged: _filterBooks,)),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _openBookmarkScreen();
                  },
                  icon: SvgPicture.asset('assets/icons/bookmark.svg'),
                ),
                Positioned(
                  // Position the badge on the top right corner of the IconButton
                  top: 4,
                  right: 4,
                  child: (bookmarkCount>0) ? Container(
                    padding: EdgeInsets.only(top: 3), // The padding inside the badge
                    decoration: BoxDecoration(
                      color: Colors.red, // Background color of the badge
                      borderRadius: BorderRadius.circular(20), // Border radius of the badge
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18, // Minimum width of the badge
                      minHeight: 18, // Minimum height of the badge
                    ),
                    child: Center(
                      child: Text(
                        bookmarkCount.toString(),
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 10,
                        ),
                      ),
                    ),
                  ): Container(),
                ),
              ],
            )

          ],
        ),

      ),

      body: BookListWidget(
          bookList: books, cubit: context.read<LibraryAllBooksCubit>()),
    );

  }

  _openBookmarkScreen (){
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
