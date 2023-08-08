import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {

  final ReferenceDatabase referenceDatabase;

  BookmarkCubit(this.referenceDatabase) : super(BookmarkState([]));

  Future<void> addBookmark(ReferenceModel bookmark) async {
    await referenceDatabase.addReference(bookmark);
    final updatedBookmarks = await referenceDatabase.getAllReference();
    emit(BookmarkState(updatedBookmarks));
  }

  Future<void> fetchBookmarks() async {
    final bookmarks = await referenceDatabase.getAllReference();
    emit(BookmarkState(bookmarks));
  }

  Future<void> filterBookmarks(String query) async {
    final bookmarks = await referenceDatabase.getFilterReference(query);
    emit(BookmarkState(bookmarks));
  }

  Future<void> updateBookmark(ReferenceModel bookmark) async {
    await referenceDatabase.updateReference(bookmark);
    final updatedBookmarks = await referenceDatabase.getAllReference();
    emit(BookmarkState(updatedBookmarks));
  }

  Future<void> deleteBookmark(int id) async {
    await referenceDatabase.deleteReference(id);
    final updatedBookmarks = await referenceDatabase.getAllReference();
    emit(BookmarkState(updatedBookmarks));
  }

}