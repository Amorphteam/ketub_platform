import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';
part 'audio_model.freezed.dart';
part 'audio_model.g.dart';

@freezed
abstract class AudioModel with _$AudioModel {
  const factory AudioModel({
    num? id,
    String? name,
    String? slug,
    String? lang,
    String? description,
    num? categoryId,
    String? pdfDownloadLink,
    String? docDownloadLink,
    String? mediaDownloadLink,
    String? fileDownloadLink,
    String? coverImage,
    num? visits,
    num? todayVisits,
    num? originalPostId,
    num? status,
    String? createdAt,
    String? modifiedAt,
    String? edaadDate,
    Category? category,
    List<Comments>? comments,
    List<String>? attachments,
  }) = _AudioModel;

  factory AudioModel.fromJson(Map<String, dynamic> json) => _$AudioModelFromJson(json);
}

@freezed
abstract class Category with _$Category {
  const factory Category({
    num? id,
    String? name,
    num? parentId,
    String? description,
    num? type,
    String? createdAt,
    String? modifiedAt,
  }) = _Category;

  factory Category.fromJson(Map<String, dynamic> json) => _$CategoryFromJson(json);
}

@freezed
abstract class Comments with _$Comments {
  const factory Comments({
    num? id,
    num? articleId,
    String? sender,
    String? email,
    String? body,
    num? replyId,
    num? status,
    dynamic reply,
    List<Replies>? replies,
    String? createdAt,
    String? modifiedAt,
  }) = _Comments;

  factory Comments.fromJson(Map<String, dynamic> json) => _$CommentsFromJson(json);
}

@freezed
abstract class Replies with _$Replies {
  const factory Replies({
    num? id,
    num? articleId,
    String? sender,
    String? email,
    String? body,
    num? replyId,
    num? status,
    String? createdAt,
    String? modifiedAt,
  }) = _Replies;

  factory Replies.fromJson(Map<String, dynamic> json) => _$RepliesFromJson(json);
}


