part of 'bookmark_cubit.dart';

abstract class BookmarkState {}

class AllBookmarkState extends BookmarkState {
  final List<ReferenceModel> bookmarks;

  AllBookmarkState(this.bookmarks);
}
