import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../repositories/articles_online_repository.dart';
import 'html_viewer_state.dart';

class HtmlViewerCubit extends Cubit<HtmlViewerState> {
  HtmlViewerCubit() : super(const HtmlViewerState.initial());

  Future<void> loadText(int? id) async {
    try {
      emit(const HtmlViewerState.loading());
      final article = await ArticleOnlineRepository().getArticles(id ?? 44621);
      final htmlString  = article.description ?? '';
      final htmlTitle = article.name ?? '';
      final htmlpubDate = article.createdAt ?? '';
      emit(HtmlViewerState.loaded(htmlContent: htmlString, htmlTitle: htmlTitle, date: htmlpubDate));
    } catch (e) {
      emit(HtmlViewerState.error(error: e.toString()));
    }
  }

}
