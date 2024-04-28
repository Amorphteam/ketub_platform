part of 'home_tree_cat_cubit.dart';

@freezed
class HomeTreeCatState with _$HomeTreeCatState {
  const factory HomeTreeCatState.initial() = _Initial;
  const factory HomeTreeCatState.loading() = _Loading;
  const factory HomeTreeCatState.loaded(List<Category> categories) = _Loaded;
  const factory HomeTreeCatState.error(String message) = _Error;
}
