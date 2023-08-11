part of 'epub_cubit.dart';

abstract class EpubState {}

class FontSizeState extends EpubState {
  FontSize fontSize;
  FontSizeState({required this.fontSize});
}
