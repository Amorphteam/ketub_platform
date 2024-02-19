import 'package:ketub_platform/models/article_model.dart';

/// count : 3210
/// posts : [{"id":49739,"name":"فقه الجهاد ـ 129","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/129.MP3","file_download_link":"","cover_image":"","visits":19,"today_visits":4,"comments_count":0,"original_post_id":0,"created_at":"2024-02-18T04:04:04Z","modified_at":"2024-01-28T14:50:02.055594Z","edaad_date":"2023-04-23 08:07:20","attachments":[]},{"id":49738,"name":"فقه الجهاد ـ 128","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/128.MP3","file_download_link":"","cover_image":"","visits":26,"today_visits":3,"comments_count":0,"original_post_id":0,"created_at":"2024-02-17T04:04:04Z","modified_at":"2024-01-28T14:49:49.64301Z","edaad_date":"2023-04-22 08:07:20","attachments":[]},{"id":49737,"name":"فقه الجهاد ـ 127","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/127.MP3","file_download_link":"","cover_image":"","visits":26,"today_visits":2,"comments_count":0,"original_post_id":0,"created_at":"2024-02-16T04:04:04Z","modified_at":"2024-01-28T14:49:36.193064Z","edaad_date":"2023-04-21 08:07:20","attachments":[]},{"id":49736,"name":"فقه الجهاد ـ 126","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/126.MP3","file_download_link":"","cover_image":"","visits":36,"today_visits":1,"comments_count":0,"original_post_id":0,"created_at":"2024-02-15T04:04:04Z","modified_at":"2024-01-28T14:49:23.959391Z","edaad_date":"2023-04-20 08:07:20","attachments":[]},{"id":49735,"name":"فقه الجهاد ـ 125","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/125.MP3","file_download_link":"","cover_image":"","visits":32,"today_visits":0,"comments_count":0,"original_post_id":0,"created_at":"2024-02-14T04:04:04Z","modified_at":"2024-01-28T14:49:06.476344Z","edaad_date":"2023-04-16 08:07:20","attachments":[]},{"id":49734,"name":"فقه الجهاد ـ 124","category_id":96,"slug":"","pdf_download_link":"","doc_download_link":"","media_download_link":"https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/124.MP3","file_download_link":"","cover_image":"","visits":24,"today_visits":0,"comments_count":0,"original_post_id":0,"created_at":"2024-02-13T04:04:04Z","modified_at":"2024-01-28T14:48:53.486438Z","edaad_date":"2023-04-15 08:07:20","attachments":[]}]

class ArticleList {
  ArticleList({
      num? count, 
      List<ArticleModel>? posts,}){
    _count = count;
    _posts = posts;
}

  ArticleList.fromJson(dynamic json) {
    _count = json['count'];
    if (json['posts'] != null) {
      _posts = [];
      json['posts'].forEach((v) {
        _posts?.add(ArticleModel.fromJson(v));
      });
    }
  }
  num? _count;
  List<ArticleModel>? _posts;
ArticleList copyWith({  num? count,
  List<ArticleModel>? posts,
}) => ArticleList(  count: count ?? _count,
  posts: posts ?? _posts,
);
  num? get count => _count;
  List<ArticleModel>? get posts => _posts;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['count'] = _count;
    if (_posts != null) {
      map['posts'] = _posts?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

