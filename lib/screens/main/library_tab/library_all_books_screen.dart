import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/screens/main/library_tab/cubit/library_all_books_cubit.dart';
import 'package:ketub_platform/screens/main/library_tab/cubit/library_all_books_state.dart';
import 'package:ketub_platform/screens/main/library_tab/widgets/book_list_widget.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

class LibraryAllBooksScreen extends StatefulWidget {
  const LibraryAllBooksScreen({Key? key}) : super(key: key);

  @override
  State<LibraryAllBooksScreen> createState() => _LibraryAllBooksScreenState();
}

class _LibraryAllBooksScreenState extends State<LibraryAllBooksScreen> {
  List<CategoryModel> cats = [];
  List<BookModel> books = [];

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
          allBooksLoaded: (books, cats) => _buildAllBooks(books, cats),
          bookClicked: (cats, id, bookName) => _buildAllBooks(books, this.cats),
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
    return BookListWidget(
        bookList: books, cubit: context.read<LibraryAllBooksCubit>());
  }
}
