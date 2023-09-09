import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/repositories/book_database.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  LibraryCubit() : super(LibraryInitState());

  final BooksDatabase booksDatabase = BooksDatabase.instance;

  Future<void> loadAllBooks() async {
    emit(LibraryLoadingState());
    try {
      final books = await booksDatabase.getAllBooks();

      emit(AllBooksLoadedState(books));
    }catch (error){
      if (error is Exception){
        emit(LibraryErrorState(error));
      }
    }
  }

  Future<void> openEpub(int catId) async{
    try {
      final category = await booksDatabase.getCategoriesByCatId(catId);
      emit(BookClickedState(category));
    }catch (error){
      if (error is Exception){
        emit(LibraryErrorState(error));
      }
    }
  }



}
