part of 'library_cubit.dart';

abstract class LibraryState {}

class LibraryInitState extends LibraryState{}
class LibraryLoadingState extends LibraryState{}


class BookClickedState extends LibraryState{
  final List<CategoryModel> cats;
  BookClickedState(this.cats);
}

class LibraryErrorState extends LibraryState{
  final Exception error;
  LibraryErrorState(this.error);
}


class AllBooksLoadedState extends LibraryState {
  final List<BookModel> books;

  AllBooksLoadedState(this.books);
}


