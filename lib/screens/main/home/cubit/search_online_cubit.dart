import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../../../models/online_search_results.dart';
import '../../../../repositories/online_repository.dart';

part 'search_online_state.dart';
part 'search_online_cubit.freezed.dart';

class SearchOnlineCubit extends Cubit<SearchOnlineState> {
  SearchOnlineCubit() : super(const SearchOnlineState.initial());

  Future<void> getSearchResults (String query) async {
    try {
      emit(const SearchOnlineState.loading());
      final results = await OnlineRepository().getSearchResults(query);
      emit(SearchOnlineState.loaded(onlineSearchResults: results));
    } catch (e) {
      emit(SearchOnlineState.error(error: e.toString()));
    }
  }
}
