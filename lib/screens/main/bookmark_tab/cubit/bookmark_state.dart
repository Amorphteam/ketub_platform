part of 'bookmark_cubit.dart';

abstract class BookmarkState {}

class AllBookmarksLoadedState extends BookmarkState {
  final List<ReferenceModel> bookmarks;
  AllBookmarksLoadedState(this.bookmarks);
}

class AllBookmarksLoadedFirestoreState extends BookmarkState {
  final List<FirestoreReferenceModel> bookmarks;
  AllBookmarksLoadedFirestoreState(this.bookmarks);
}


class BookmarkDeletedState extends BookmarkState {}

class BookmarkLoadingState extends BookmarkState {}

class BookmarkInitState extends BookmarkState {}

class BookmarkErrorState extends BookmarkState {
  final Exception error;
  BookmarkErrorState(this.error);
}

class BookmarkTappedState extends BookmarkState {
  final ReferenceModel item;
  BookmarkTappedState(this.item);
}

class BookmarkTappedFirestoreState extends BookmarkState {
  final FirestoreReferenceModel item;
  BookmarkTappedFirestoreState(this.item);
}


