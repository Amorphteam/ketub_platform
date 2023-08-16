import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/repositories/reference_database.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitState());

  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;

  Future<void> loadAllBookmarks() async {
    emit(BookmarkLoadingState());
    try {
      final bookmarks = await referencesDatabase.getAllReferences();
      emit(AllBookmarksLoadedState(bookmarks));
    } catch (error) {
      if (error is Exception) {
        emit(BookmarkErrorState(error));
      }
    }
  }

  Future<void> addBookmark(ReferenceModel bookmark) async {
    emit(BookmarkLoadingState());
    try {
      await referencesDatabase.addReference(bookmark);
      emit(BookmarkAddedState());
      loadAllBookmarks();
    } catch (error) {
      if (error is Exception){
        emit(BookmarkErrorState(error));
      }
    }

  }

  Future<void> deleteBookmark(int id) async {
    emit(BookmarkLoadingState());
    try {
      await referencesDatabase.deleteReference(id);
      emit(BookmarkDeletedState());
      loadAllBookmarks();
    } catch (error){
      if (error is Exception){
        emit(BookmarkErrorState(error));
      }
    }
  }

  Future<void> filterBookmarks(String query) async {
    emit(BookmarkLoadingState());
    try {
      final bookmarks = await referencesDatabase.getFilterReference(query);
      emit(AllBookmarksLoadedState(bookmarks));
    } catch (error) {
      if (error is Exception) {
        emit(BookmarkErrorState(error));
      }
    }
  }

  void openEpub(ReferenceModel item){
    emit(BookmarkTappedState(item));
  }
}
