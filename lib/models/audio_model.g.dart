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
          categoryId: json['category_id'] as num?,
          pdfDownloadLink: json['pdf_download_link'] as String?,
          docDownloadLink: json['doc_download_link'] as String?,
          mediaDownloadLink: json['media_download_link'] as String?,
          fileDownloadLink: json['file_download_link'] as String?,
          coverImage: json['cover_image'] as String?,
          visits: json['visits'] as num?,
          todayVisits: json['today_visits'] as num?,
          originalPostId: json['original_post_id'] as num?,
          status: json['status'] as num?,
          createdAt: json['created_at'] as String?,
          modifiedAt: json['modified_at'] as String?,
          edaadDate: json['edaad_date'] as String?,
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
          'category_id': instance.categoryId,
          'pdf_download_link': instance.pdfDownloadLink,
          'doc_download_link': instance.docDownloadLink,
          'media_download_link': instance.mediaDownloadLink,
          'file_download_link': instance.fileDownloadLink,
          'cover_image': instance.coverImage,
          'visits': instance.visits,
          'today_visits': instance.todayVisits,
          'original_post_id': instance.originalPostId,
          'status': instance.status,
          'created_at': instance.createdAt,
          'modified_at': instance.modifiedAt,
          'edaad_date': instance.edaadDate,
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
