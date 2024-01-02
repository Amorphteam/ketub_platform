import 'package:bloc/bloc.dart';
import 'package:ketub_platform/utils/style_handler.dart';
import 'package:meta/meta.dart';

part 'webview_state.dart';

class WebviewCubit extends Cubit<WebviewState> {
  WebviewCubit() : super(WebviewInitial());

  Future<void> loadModifiedContent(String content) async {
    emit(WebviewLoading());
    final String contentWithStyle = await injectCssJs(content);
    emit(WebviewLoaded(content: contentWithStyle));
  }
}
