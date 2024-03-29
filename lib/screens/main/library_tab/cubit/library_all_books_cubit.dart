import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/repositories/book_database.dart';

import '../../../../repositories/reference_database.dart';
import 'library_all_books_state.dart';

class LibraryAllBooksCubit extends Cubit<LibraryAllBooksState> {
  LibraryAllBooksCubit() : super(const LibraryAllBooksState.init());
  List<BookModel>? books;
  List<CategoryModel>? cats;
  final BooksDatabase booksDatabase = BooksDatabase.instance;

  Future<void> loadAllBooks() async {
    emit(const LibraryAllBooksState.loading());
    try {
      final books = await booksDatabase.getAllBooks();
      final cats = await booksDatabase.getAllCats();
      _storeData(books, cats);
      emit(LibraryAllBooksState.allBooksLoaded(books: books, cats: cats));
    } catch (error) {
      if (error is Exception) {
        emit(LibraryAllBooksState.error(error: error));
      }
    }
  }

  Future<void> openEpub(int catId, String bookName) async {
    try {
      final category = await booksDatabase.getCategoriesByCatId(catId);
      emit(LibraryAllBooksState.bookClicked(cats: category, id: catId, bookName: bookName));
    } catch (error) {
      if (error is Exception) {
        emit(LibraryAllBooksState.error(error: error));
      }
    }
  }

  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;

  Future<void> loadAllBookmarks() async {
    try {
      final bookmarksCount = await referencesDatabase.getCountOfAllReferences();
      emit(LibraryAllBooksState.allBookmarksCountLoaded(count: bookmarksCount));
    } catch (error) {
      if (error is Exception) {
        emit(LibraryAllBooksState.error(error: error));
      }
    }
  }

  void filterBooks(String query) {
      List<BookModel>? filteredBooks;
      if (query.isEmpty) {
        filteredBooks = books;
      } else {
        filteredBooks = books!
            .where((book) => book.bookName!.toLowerCase().contains(query.toLowerCase()))
            .toList();
      }

      emit(LibraryAllBooksState.filteredBooksLoaded(filteredBooks: filteredBooks?? [], cats: cats?? []));

  }

  void _storeData(List<BookModel> books, List<CategoryModel> cats) {
    this.books = books;
    this.cats = cats;
  }

}
