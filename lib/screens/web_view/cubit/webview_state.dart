part of 'webview_cubit.dart';

@immutable
abstract class WebviewState {}

class WebviewInitial extends WebviewState {}
class WebviewLoading extends WebviewState {}
class WebviewError extends WebviewState {}
class WebviewLoaded extends WebviewState {
  final String content;
  WebviewLoaded({required this.content});
}


