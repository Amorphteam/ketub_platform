import 'package:bloc/bloc.dart';
import 'package:ketub_platform/models/firestore_reference_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/repositories/reference_database.dart';

import '../../../../repositories/firestore_references_database.dart';

part 'bookmark_state.dart';

class BookmarkCubit extends Cubit<BookmarkState> {
  BookmarkCubit() : super(BookmarkInitState());

  final ReferencesDatabase referencesDatabase = ReferencesDatabase.instance;
  final FirestoreReferencesDatabase _firestoreReferencesDatabase = FirestoreReferencesDatabase();

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

  Future<void> loadAllBookmarkFromFirestore() async {
    emit(BookmarkLoadingState());
    try {
      final bookmarks = await _firestoreReferencesDatabase.getAllReferences();
      emit(AllBookmarksLoadedFirestoreState(bookmarks));
    } catch (error) {
      if (error is Exception) {
        emit(BookmarkErrorState(error));
      }
    }
  }

  Future<void> deleteBookmarkFromFirestore(String bookPath, String navIndex) async {
    emit(BookmarkLoadingState());
    try {
      await _firestoreReferencesDatabase.deleteReference(bookPath, navIndex);
      emit(BookmarkDeletedState());
      loadAllBookmarkFromFirestore();
    } catch (error) {
      if (error is Exception) {
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
  Future<void> filterBookmarksFromFirestore(String query) async {
    emit(BookmarkLoadingState());
    try {
      final bookmarks = await _firestoreReferencesDatabase.getFilterReference(query);
      emit(AllBookmarksLoadedFirestoreState(bookmarks));
    } catch (error) {
      if (error is Exception) {
        emit(BookmarkErrorState(error));
      }
    }
  }

  void openEpub(ReferenceModel item){
    emit(BookmarkTappedState(item));
  }

  void openEpubFromFirestore(FirestoreReferenceModel item){
    emit(BookmarkTappedFirestoreState(item));
  }
}
