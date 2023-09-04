part of 'toc_cubit.dart';

abstract class TocState {}

class TocInitialState extends TocState {}

class TocLoadingState extends TocState {}
class TocErrorState extends TocState {
  final Exception error;
  TocErrorState(this.error);
}

class TocLoadedState extends TocState{
  final List<TreeTocModel> tocTreeList;
  TocLoadedState(this.tocTreeList);
}

class TocItemTappedState extends TocState{
  final TreeTocModel toc;
  TocItemTappedState(this.toc);
}

