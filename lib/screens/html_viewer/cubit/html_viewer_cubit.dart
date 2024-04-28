import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/online_repository.dart';
import 'html_viewer_state.dart';

class HtmlViewerCubit extends Cubit<HtmlViewerState> {
  HtmlViewerCubit() : super(const HtmlViewerState.initial());

  Future<void> loadText(int? id) async {
    try {
      emit(const HtmlViewerState.loading());
      final article = await OnlineRepository().getArticles(id ?? 44621);
      emit(HtmlViewerState.loaded(articleModel: article));
    } catch (e) {
      emit(HtmlViewerState.error(error: e.toString()));
    }
  }

}
