part of 'epub_cubit.dart';

abstract class EpubState {}

class EpubInitState extends EpubState{}
class EpubLoadingState extends EpubState{}
class EpubErrorState extends EpubState{
  final String error;
  EpubErrorState(this.error);
}

class SpineEpubLoadedState extends EpubState{
  final List<String> spine;

  SpineEpubLoadedState(this.spine);
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