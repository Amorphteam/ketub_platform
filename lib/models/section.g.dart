// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'section.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$SectionImpl _$$SectionImplFromJson(Map<String, dynamic> json) =>
    _$SectionImpl(
      id: json['id'] as int?,
      title: json['title'] as String,
      bookPath: json['bookPath'] as String,
      bookName: json['bookName'] as String,
      sectionIndex: json['sectionIndex'] as int,
    );

Map<String, dynamic> _$$SectionImplToJson(_$SectionImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'bookPath': instance.bookPath,
      'bookName': instance.bookName,
      'sectionIndex': instance.sectionIndex,
    };
