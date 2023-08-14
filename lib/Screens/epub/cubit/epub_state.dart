part of 'epub_cubit.dart';

abstract class EpubState {}

class FontSizeState extends EpubState {
  FontSize fontSize;
  FontSizeState({required this.fontSize});
}

class LineSpaceState extends EpubState {
  LineSpace lineSpace;
  LineSpaceState({required this.lineSpace});
}

class FontFamilyState extends EpubState {
  FontFamily fontFamily;
  FontFamilyState({required this.fontFamily});
}