import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/models/article_model.dart';
part 'html_viewer_state.freezed.dart';
@freezed
class HtmlViewerState with _$HtmlViewerState {
  const factory HtmlViewerState.initial() = _Initial;
  const factory HtmlViewerState.loading() = _Loading;
  const factory HtmlViewerState.loaded({required ArticleModel articleModel}) = _Loaded;
  const factory HtmlViewerState.error({String? error}) = _Error;
}
