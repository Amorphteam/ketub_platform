part of 'epub_viewer_cubit.dart';

@freezed
class EpubViewerState with _$EpubViewerState {
  const factory EpubViewerState.initial() = _Initial;
  const factory EpubViewerState.loading() = _Loading;
  const factory EpubViewerState.loaded({required List<String> content, required String epubTitle, List<EpubChapter>? tocTreeList}) = _Loaded;
  const factory EpubViewerState.error({required String error}) = _error;
  const factory EpubViewerState.pageChanged({int? pageNumber}) = _PageChanged;
  const factory EpubViewerState.styleChanged({FontSizeCustom? fontSize, LineHeightCustom? lineHeight, FontFamily? fontFamily}) = _StyleChanged;
  const factory EpubViewerState.bookmarkAdded({int? status}) = _BookmarkAdded;
  const factory EpubViewerState.searchResultsFound({required List<SearchModel> searchResults}) = _SearchResultsFound;
  const factory EpubViewerState.bookmarkPresent() = _BookmarkPresent;
  const factory EpubViewerState.bookmarkAbsent() = _BookmarkAbsent;

}
