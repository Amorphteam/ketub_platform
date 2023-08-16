part of 'bookmark_cubit.dart';

abstract class BookmarkState {}

class AllBookmarksLoadedState extends BookmarkState {
  final List<ReferenceModel> bookmarks;
  AllBookmarksLoadedState(this.bookmarks);
}

class BookmarkAddedState extends BookmarkState {}

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


