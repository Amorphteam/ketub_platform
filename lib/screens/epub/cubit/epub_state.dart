part of 'epub_cubit.dart';

abstract class EpubState {}

class EpubInitState extends EpubState{}
class EpubLoadingState extends EpubState{}

class EpubErrorState extends EpubState{
  final String error;
  EpubErrorState({required this.error});
}

class EpubContentLoadedState extends EpubState {
  final List<String> content;
  final int? pageIndex;
  EpubContentLoadedState({required this.content, this.pageIndex});
}

class EpubPageLoadedState extends EpubState {
  final int? spineNumber;
  EpubPageLoadedState({ this.spineNumber});
}

class EpubTitleLoadedState extends EpubState {
  final String bookTitle;
  EpubTitleLoadedState({required this.bookTitle});
}



//TODO: REFACTOR AND RENAME
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

class TocLoadingState extends EpubState {}

class ErrorState extends EpubState {
  final Exception error;
  ErrorState(this.error);
}

class TocLoadedState extends EpubState{
  final List<EpubChapter> tocTreeList;
  TocLoadedState(this.tocTreeList);
}

class TocItemTappedState extends EpubState{
  final EpubChapter toc;
  TocItemTappedState(this.toc);
}

class LastPageSeenChangedState extends EpubState {
  final double page;
  LastPageSeenChangedState({required this.page});
}
