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

import '../../../models/section.dart';
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
  List<Section> tocs = [];
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
          allBooksLoaded: (books, cats, tocs) {
            _loadAllBookmarksCount();
            this.tocs = tocs;
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
      body: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Stack(
              alignment: Alignment.topCenter,
              children: [
                Image.asset(
                  'assets/images/nosos_bk_header.png',
                  height: 220,
                  width: MediaQuery.of(context).size.width,
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
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
                  (context, index) {
                late final List<BookModel> currentBookList;
                late final String logo;
                late final String title;

                if (index == 0) {
                  currentBookList = books.where((book) => book.bookName?.contains('نصوص معاصرة') ?? false).toList();
                  logo = 'assets/images/ejtihad_logo.png';
                  title = 'نصوص معاصرة';
                } else if (index == 1) {
                  currentBookList = books.where((book) => book.bookName?.contains('الاجتهاد والتجديد') ?? false).toList();
                  logo = 'assets/images/nosos_logo.png';
                  title = 'الاجتهاد والتجديد';
                } else if (index == 2) {
                  currentBookList = books.where((book) => book.bookName?.contains('كتب المجلة') ?? false).toList();
                  logo = 'assets/images/nosos_logo.png';
                  title = 'كتب المجلة';
                } else {
                  debugPrint('TOC index: $tocs');
                  return Padding(
                    padding: const EdgeInsets.only(top: 40.0, bottom: 10.0),
                    child: Column(
                      children: [
                        Text(
                          'مقالات مهمة',
                          style: Theme.of(context).textTheme.titleLarge,
                          textAlign: TextAlign.right,
                        ),
                        ...tocs.map((toc) => ListTile(
                          leading: Image.asset(
                            toc.bookName.contains('الاجتهاد والتجديد')
                                ? 'assets/images/ejtihad_logo.png'
                                : 'assets/images/nosos_logo.png',
                            width: 40,
                          ),
                          title: Text(toc.title),
                          onTap: () {
                            // Implement TOC item tap handler
                          },
                        ))

                      ],
                    ),
                  );
                }

                return BookListWidget(
                  bookList: currentBookList,
                  cubit: context.read<LibraryAllBooksCubit>(),
                  logo: logo,
                  title: title,
                );
              },
              // Set the child count to the number of categories plus one for the TOC
              childCount: 4,
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
