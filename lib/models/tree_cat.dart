import 'package:freezed_annotation/freezed_annotation.dart';

part 'tree_cat.freezed.dart';
part 'tree_cat.g.dart';

@freezed
class TreeCat with _$TreeCat {
  const factory TreeCat({
    List<Category>? categories,
  }) = _TreeCat;

  factory TreeCat.fromJson(Map<String, dynamic> json) =>
      _$TreeCatFromJson(json);
}

@freezed
class Category with _$Category {
  const factory Category({
    num? id,
    String? name,
    num? parentId,
    String? description,
    num? type,
    String? createdAt,
    String? modifiedAt,
    List<Category>? children,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) =>
      _$CategoryFromJson(json);
}
