import 'package:flutter/foundation.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'list_type_model.freezed.dart';
part 'list_type_model.g.dart';

@freezed
class ListTypeModel with _$ListTypeModel {
  const factory ListTypeModel({
    required ListType listType,
    required String title,
    @Default(false) bool hasSubLists,
    required String featureImageUrl,
  }) = _ListTypeModel;

  factory ListTypeModel.fromJson(Map<String, dynamic> json) => _$ListTypeModelFromJson(json);
}


enum ListType {
  simpleList,
  gridList,
}
