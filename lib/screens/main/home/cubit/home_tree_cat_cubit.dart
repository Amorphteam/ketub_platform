import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../../../../models/tree_cat.dart';
import '../../../../repositories/online_repository.dart';
import '../../../../utils/data_helper.dart';

part 'home_tree_cat_state.dart';
part 'home_tree_cat_cubit.freezed.dart';

class HomeTreeCatCubit extends Cubit<HomeTreeCatState> {
  HomeTreeCatCubit() : super(const HomeTreeCatState.initial());

  Future<void> loadCategories() async {
    final prefs = await SharedPreferences.getInstance();
    String? cachedData = prefs.getString('cachedTreeCat');

    if (cachedData != null) {
      // Load from cache
      List<dynamic> cachedList = jsonDecode(cachedData);
      List<Category> categories = cachedList.map((jsonCat) => Category.fromJson(jsonCat)).toList();
      emit(HomeTreeCatState.loaded(categories));
    } else {
      // Fetch from network and cache the data
      emit(const HomeTreeCatState.loading());
      try {
        List<Category> categories = await _getCombinedCategories();
        prefs.setString('cachedTreeCat', jsonEncode(categories.map((cat) => cat.toJson()).toList()));
        emit(HomeTreeCatState.loaded(categories));
      } catch (e) {
        emit(HomeTreeCatState.error(e.toString()));
      }
    }
  }

  Future<List<Category>> _getCombinedCategories() async {
    List<Category> combinedCategories = [];

    for (var entry in DataHelper.categories.entries) {
      var treeCat = await OnlineRepository().getTreeCat(entry.value);
      combinedCategories.add(
          Category(name: entry.key, children: treeCat.categories));
    }

    return combinedCategories;
  }
}

