import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/repositories/book_database.dart';

part 'library_state.dart';

class LibraryCubit extends Cubit<LibraryState> {
  final BookDatabase bookDatabase;

  LibraryCubit(this.bookDatabase) : super(AllBookState([]));

  Future<void> fetchBooks() async {
    final books = await bookDatabase.getAllBooks();
    emit(AllBookState(books));
  }
}
