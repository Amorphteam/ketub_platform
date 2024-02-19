part of 'home_all_cat_cubit.dart';

@freezed
class HomeAllCatState with _$HomeAllCatState {
  const factory HomeAllCatState.initial() = _Initial;
  const factory HomeAllCatState.loading() = _Loading;
  const factory HomeAllCatState.loaded({required List<CardTypeModel> cardList}) = _loaded;
  const factory HomeAllCatState.error(String message) = _Error;

}
