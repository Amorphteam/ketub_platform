// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'audio_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$AudioModelImpl _$$AudioModelImplFromJson(Map<String, dynamic> json) =>
    _$AudioModelImpl(
      id: json['id'] as num?,
      name: json['name'] as String?,
      slug: json['slug'] as String?,
      lang: json['lang'] as String?,
      description: json['description'] as String?,
      categoryId: json['categoryId'] as num?,
      pdfDownloadLink: json['pdfDownloadLink'] as String?,
      docDownloadLink: json['docDownloadLink'] as String?,
      mediaDownloadLink: json['mediaDownloadLink'] as String?,
      fileDownloadLink: json['fileDownloadLink'] as String?,
      coverImage: json['coverImage'] as String?,
      visits: json['visits'] as num?,
      todayVisits: json['todayVisits'] as num?,
      originalPostId: json['originalPostId'] as num?,
      status: json['status'] as num?,
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
      edaadDate: json['edaadDate'] as String?,
      category: json['category'] == null
          ? null
          : Category.fromJson(json['category'] as Map<String, dynamic>),
      comments: (json['comments'] as List<dynamic>?)
          ?.map((e) => Comments.fromJson(e as Map<String, dynamic>))
          .toList(),
      attachments: (json['attachments'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$AudioModelImplToJson(_$AudioModelImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'slug': instance.slug,
      'lang': instance.lang,
      'description': instance.description,
      'categoryId': instance.categoryId,
      'pdfDownloadLink': instance.pdfDownloadLink,
      'docDownloadLink': instance.docDownloadLink,
      'mediaDownloadLink': instance.mediaDownloadLink,
      'fileDownloadLink': instance.fileDownloadLink,
      'coverImage': instance.coverImage,
      'visits': instance.visits,
      'todayVisits': instance.todayVisits,
      'originalPostId': instance.originalPostId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
      'edaadDate': instance.edaadDate,
      'category': instance.category,
      'comments': instance.comments,
      'attachments': instance.attachments,
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
    };

_$CommentsImpl _$$CommentsImplFromJson(Map<String, dynamic> json) =>
    _$CommentsImpl(
      id: json['id'] as num?,
      articleId: json['articleId'] as num?,
      sender: json['sender'] as String?,
      email: json['email'] as String?,
      body: json['body'] as String?,
      replyId: json['replyId'] as num?,
      status: json['status'] as num?,
      reply: json['reply'],
      replies: (json['replies'] as List<dynamic>?)
          ?.map((e) => Replies.fromJson(e as Map<String, dynamic>))
          .toList(),
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
    );

Map<String, dynamic> _$$CommentsImplToJson(_$CommentsImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'sender': instance.sender,
      'email': instance.email,
      'body': instance.body,
      'replyId': instance.replyId,
      'status': instance.status,
      'reply': instance.reply,
      'replies': instance.replies,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
    };

_$RepliesImpl _$$RepliesImplFromJson(Map<String, dynamic> json) =>
    _$RepliesImpl(
      id: json['id'] as num?,
      articleId: json['articleId'] as num?,
      sender: json['sender'] as String?,
      email: json['email'] as String?,
      body: json['body'] as String?,
      replyId: json['replyId'] as num?,
      status: json['status'] as num?,
      createdAt: json['createdAt'] as String?,
      modifiedAt: json['modifiedAt'] as String?,
    );

Map<String, dynamic> _$$RepliesImplToJson(_$RepliesImpl instance) =>
    <String, dynamic>{
      'id': instance.id,
      'articleId': instance.articleId,
      'sender': instance.sender,
      'email': instance.email,
      'body': instance.body,
      'replyId': instance.replyId,
      'status': instance.status,
      'createdAt': instance.createdAt,
      'modifiedAt': instance.modifiedAt,
    };
