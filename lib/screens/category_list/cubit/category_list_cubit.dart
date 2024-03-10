import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/article_list.dart';
import '../../../models/article_model.dart';
import '../../../repositories/articles_online_repository.dart';

part 'category_list_state.dart';
part 'category_list_cubit.freezed.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  CategoryListCubit() : super(const CategoryListState.initial());

  Future<void> loadArticlesList(String catName) async {
    try {
      emit(const CategoryListState.loading());
      final list = await ArticleOnlineRepository().getArticlesList(100, 0, catName);
      emit(CategoryListState.loaded(articles: list));
    } catch (e) {
      emit(CategoryListState.error(error: e.toString()));
    }
  }
}
