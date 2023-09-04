part of 'epub_cubit.dart';

abstract class EpubState {}

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