import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../models/article_list.dart';
import '../../../models/article_model.dart';
import '../../../models/tree_cat.dart';
import '../../../repositories/online_repository.dart';

part 'category_list_state.dart';
part 'category_list_cubit.freezed.dart';

class CategoryListCubit extends Cubit<CategoryListState> {
  CategoryListCubit() : super(const CategoryListState.initial());

  Future<void> loadArticlesList({String? catNameUrl, String? catId}) async {
    try {
      emit(const CategoryListState.loading());
      ArticleList list;
      if (catNameUrl != null){
        list = await OnlineRepository().getArticlesList(100, 0, catNameUrl ?? '');
      }else {
        list = await OnlineRepository().getArticlesListFromCatId(100, 0, catId ?? '');
      }
      emit(CategoryListState.loaded(articles: list));
    } catch (e) {
      emit(CategoryListState.error(error: e.toString()));
    }
  }


  Future<void> loadTreeCats({required String sectionName}) async {
    try {
      emit(const CategoryListState.loading());
      var treeCat = await OnlineRepository().getTreeCat(sectionName);

      emit(CategoryListState.treeCat(treeCat: treeCat));
    } catch (e) {
      emit(CategoryListState.error(error: e.toString()));
    }
  }

}
