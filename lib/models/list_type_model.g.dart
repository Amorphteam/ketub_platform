// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$ListTypeModelImpl _$$ListTypeModelImplFromJson(Map<String, dynamic> json) =>
    _$ListTypeModelImpl(
      listType: $enumDecode(_$ListTypeEnumMap, json['listType']),
      title: json['title'] as String,
      hasSubLists: json['hasSubLists'] as bool? ?? false,
      featureImageUrl: json['featureImageUrl'] as String,
    );

Map<String, dynamic> _$$ListTypeModelImplToJson(_$ListTypeModelImpl instance) =>
    <String, dynamic>{
      'listType': _$ListTypeEnumMap[instance.listType]!,
      'title': instance.title,
      'hasSubLists': instance.hasSubLists,
      'featureImageUrl': instance.featureImageUrl,
    };

const _$ListTypeEnumMap = {
  ListType.simpleList: 'simpleList',
  ListType.gridList: 'gridList',
};
