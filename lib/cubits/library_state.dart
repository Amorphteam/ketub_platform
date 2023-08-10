part of 'library_cubit.dart';

abstract class LibraryState {}

class AllBookState extends LibraryState {
  final List<BookModel> books;

  AllBookState(this.books);
}
