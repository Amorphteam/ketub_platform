// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'firestore_reference_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$FirestoreReferenceModelImpl _$$FirestoreReferenceModelImplFromJson(
        Map<String, dynamic> json) =>
    _$FirestoreReferenceModelImpl(
      userId: json['userId'] as String,
      title: json['title'] as String,
      bookName: json['bookName'] as String,
      bookPath: json['bookPath'] as String,
      navIndex: json['navIndex'] as String,
    );

Map<String, dynamic> _$$FirestoreReferenceModelImplToJson(
        _$FirestoreReferenceModelImpl instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'title': instance.title,
      'bookName': instance.bookName,
      'bookPath': instance.bookPath,
      'navIndex': instance.navIndex,
    };
