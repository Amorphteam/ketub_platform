// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'tree_cat.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$TreeCatImpl _$$TreeCatImplFromJson(Map<String, dynamic> json) =>
    _$TreeCatImpl(
      categories: (json['categories'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$TreeCatImplToJson(_$TreeCatImpl instance) =>
    <String, dynamic>{
      'categories': instance.categories,
    };

_$CategoryImpl _$$CategoryImplFromJson(Map<String, dynamic> json) =>
    _$CategoryImpl(
      id: json['id'] as num?,
      name: json['name'] as String?,
      parentId: json['parentId'] as num?,
      description: json['description'] as String?,
      type: json['type'] as num?,
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
      children: (json['children'] as List<dynamic>?)
          ?.map((e) => Category.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$$CategoryImplToJson(_$CategoryImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'parentId': instance.parentId,
      'description': instance.description,
      'type': instance.type,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'children': instance.children,
    };
