part of 'search_online_cubit.dart';

@freezed
class SearchOnlineState with _$SearchOnlineState {
  const factory SearchOnlineState.initial() = _Initial;
  const factory SearchOnlineState.loading() = _loading;
  const factory SearchOnlineState.loaded({required OnlineSearchResults onlineSearchResults}) = _Loaded;
  const factory SearchOnlineState.error({required String error}) = _Error;
}
