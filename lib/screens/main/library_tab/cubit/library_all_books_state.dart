import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';

part 'library_all_books_state.freezed.dart';

@freezed
class LibraryAllBooksState with _$LibraryAllBooksState {
  const factory LibraryAllBooksState.init() = _Initial;
  const factory LibraryAllBooksState.loading() = _Loading;
  const factory LibraryAllBooksState.allBooksLoaded({
    required List<BookModel> books,
    required List<CategoryModel> cats,
  }) = _Loaded;
  const factory LibraryAllBooksState.bookClicked({
    required List<CategoryModel> cats,
    required int id,
    required String bookName,
  }) = _OpenEpub;
  const factory LibraryAllBooksState.error({required Exception error}) = _Error;
}
