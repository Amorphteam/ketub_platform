part of 'epub_cubit.dart';

abstract class EpubState {}

class EpubInitState extends EpubState{}
class EpubLoadingState extends EpubState{}
class EpubErrorState extends EpubState{
  final String error;
  EpubErrorState(this.error);
}

class SpineLoadedState extends EpubState {
  final List<String> spine;
  final int? spineNumber;

  SpineLoadedState({required this.spine, this.spineNumber});
}

class BookTitleLoadedState extends EpubState{
  final String bookTitle;

  BookTitleLoadedState(this.bookTitle);
}

class FontSizeChangedState extends EpubState {
  final FontSize fontSize;
  FontSizeChangedState({required this.fontSize});
}

class LineSpaceChangedState extends EpubState {
  final LineSpace lineSpace;
  LineSpaceChangedState({required this.lineSpace});
}

class FontFamilyChangedState extends EpubState {
  final FontFamily fontFamily;
  FontFamilyChangedState({required this.fontFamily});
}

class BookmarkAddedState extends EpubState {
  final int addStatus;
  BookmarkAddedState(this.addStatus);
}

class PageChangedState extends EpubState {
  final int newPage;

  PageChangedState(this.newPage);
}