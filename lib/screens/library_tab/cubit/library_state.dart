part of 'library_cubit.dart';

abstract class LibraryState {}

class LibraryInitState extends LibraryState{}
class LibraryLoadingState extends LibraryState{}

class BookClickedState extends LibraryState{
  final BookModel book;
  BookClickedState(this.book);
}
class CatClickedState extends LibraryState{
  final CategoryModel cat;
  CatClickedState(this.cat);
}

class LibraryErrorState extends LibraryState{
  final Exception error;
  LibraryErrorState(this.error);
}


class AllBooksLoadedState extends LibraryState {
  final List<BookModel> books;
  final List<CategoryModel> cats;

  AllBooksLoadedState(this.books, this.cats);
}


