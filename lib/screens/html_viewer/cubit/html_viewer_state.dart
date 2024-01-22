import 'package:freezed_annotation/freezed_annotation.dart';
part 'html_viewer_state.freezed.dart';
@freezed
class HtmlViewerState with _$HtmlViewerState {
  const factory HtmlViewerState.initial() = _Initial;
  const factory HtmlViewerState.loading() = _Loading;
  const factory HtmlViewerState.loaded({required String htmlContent, required String htmlTitle, required String date}) = _Loaded;
  const factory HtmlViewerState.error({String? error}) = _Error;
}
