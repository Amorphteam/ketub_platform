part of 'epub_viewer_cubit.dart';

@freezed
class EpubViewerState with _$EpubViewerState {
  const factory EpubViewerState.initial() = _Initial;
  const factory EpubViewerState.loading() = _Loading;
  const factory EpubViewerState.loaded({required List<String> content, required String epubTitle}) = _Loaded;
  const factory EpubViewerState.error({required String error}) = _error;
  const factory EpubViewerState.pageChanged({int? pageNumber}) = _PageChanged;
  const factory EpubViewerState.styleChanged({FontSizeCustom? fontSize, LineSpace? lineHeight, FontFamily? fontFamily}) = _StyleChanged;

}
