part of 'category_list_cubit.dart';

@freezed
class CategoryListState with _$CategoryListState {
  const factory CategoryListState.initial() = _Initial;
  const factory CategoryListState.loading() = _Loading;
  const factory CategoryListState.loaded({required ArticleList articles}) = _Loaded;
  const factory CategoryListState.treeCat({required TreeCat treeCat}) = _TreeCatLoaded;
  const factory CategoryListState.error({required String error}) = _Error;
}
