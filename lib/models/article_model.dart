
class ArticleModel {
  ArticleModel({
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
      List<String>? attachments,}){
    _id = id;
    _name = name;
    _slug = slug;
    _lang = lang;
    _description = description;
    _categoryId = categoryId;
    _pdfDownloadLink = pdfDownloadLink;
    _docDownloadLink = docDownloadLink;
    _mediaDownloadLink = mediaDownloadLink;
    _fileDownloadLink = fileDownloadLink;
    _coverImage = coverImage;
    _visits = visits;
    _todayVisits = todayVisits;
    _originalPostId = originalPostId;
    _status = status;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
    _edaadDate = edaadDate;
    _category = category;
    _comments = comments;
}

  ArticleModel.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _slug = json['slug'];
    _lang = json['lang'];
    _description = json['description'];
    _categoryId = json['category_id'];
    _pdfDownloadLink = json['pdf_download_link'];
    _docDownloadLink = json['doc_download_link'];
    _mediaDownloadLink = json['media_download_link'];
    _fileDownloadLink = json['file_download_link'];
    _coverImage = json['cover_image'];
    _visits = json['visits'];
    _todayVisits = json['today_visits'];
    _originalPostId = json['original_post_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
    _edaadDate = json['edaad_date'];
    _category = json['category'] != null ? Category.fromJson(json['category']) : null;
    if (json['comments'] != null) {
      _comments = [];
      json['comments'].forEach((v) {
        _comments?.add(Comments.fromJson(v));
      });
    }

  }
  num? _id;
  String? _name;
  String? _slug;
  String? _lang;
  String? _description;
  num? _categoryId;
  String? _pdfDownloadLink;
  String? _docDownloadLink;
  String? _mediaDownloadLink;
  String? _fileDownloadLink;
  String? _coverImage;
  num? _visits;
  num? _todayVisits;
  num? _originalPostId;
  num? _status;
  String? _createdAt;
  String? _modifiedAt;
  String? _edaadDate;
  Category? _category;
  List<Comments>? _comments;
  List<String>? _attachments;
ArticleModel copyWith({  num? id,
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
  List<dynamic>? attachments,
}) => ArticleModel(  id: id ?? _id,
  name: name ?? _name,
  slug: slug ?? _slug,
  lang: lang ?? _lang,
  description: description ?? _description,
  categoryId: categoryId ?? _categoryId,
  pdfDownloadLink: pdfDownloadLink ?? _pdfDownloadLink,
  docDownloadLink: docDownloadLink ?? _docDownloadLink,
  mediaDownloadLink: mediaDownloadLink ?? _mediaDownloadLink,
  fileDownloadLink: fileDownloadLink ?? _fileDownloadLink,
  coverImage: coverImage ?? _coverImage,
  visits: visits ?? _visits,
  todayVisits: todayVisits ?? _todayVisits,
  originalPostId: originalPostId ?? _originalPostId,
  status: status ?? _status,
  createdAt: createdAt ?? _createdAt,
  modifiedAt: modifiedAt ?? _modifiedAt,
  edaadDate: edaadDate ?? _edaadDate,
  category: category ?? _category,
  comments: comments ?? _comments,
);
  num? get id => _id;
  String? get name => _name;
  String? get slug => _slug;
  String? get lang => _lang;
  String? get description => _description;
  num? get categoryId => _categoryId;
  String? get pdfDownloadLink => _pdfDownloadLink;
  String? get docDownloadLink => _docDownloadLink;
  String? get mediaDownloadLink => _mediaDownloadLink;
  String? get fileDownloadLink => _fileDownloadLink;
  String? get coverImage => _coverImage;
  num? get visits => _visits;
  num? get todayVisits => _todayVisits;
  num? get originalPostId => _originalPostId;
  num? get status => _status;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;
  String? get edaadDate => _edaadDate;
  Category? get category => _category;
  List<Comments>? get comments => _comments;
  List<dynamic>? get attachments => _attachments;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['slug'] = _slug;
    map['lang'] = _lang;
    map['description'] = _description;
    map['category_id'] = _categoryId;
    map['pdf_download_link'] = _pdfDownloadLink;
    map['doc_download_link'] = _docDownloadLink;
    map['media_download_link'] = _mediaDownloadLink;
    map['file_download_link'] = _fileDownloadLink;
    map['cover_image'] = _coverImage;
    map['visits'] = _visits;
    map['today_visits'] = _todayVisits;
    map['original_post_id'] = _originalPostId;
    map['status'] = _status;
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    map['edaad_date'] = _edaadDate;
    if (_category != null) {
      map['category'] = _category?.toJson();
    }
    if (_comments != null) {
      map['comments'] = _comments?.map((v) => v.toJson()).toList();
    }
    return map;
  }

}

class Category {
  Category({
    num? id,
    String? name,
    num? parentId,
    String? description,
    num? type,
    String? createdAt,
    String? modifiedAt,}){
    _id = id;
    _name = name;
    _parentId = parentId;
    _description = description;
    _type = type;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
  }

  Category.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
    _parentId = json['parent_id'];
    _description = json['description'];
    _type = json['type'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }
  num? _id;
  String? _name;
  num? _parentId;
  String? _description;
  num? _type;
  String? _createdAt;
  String? _modifiedAt;
  Category copyWith({  num? id,
    String? name,
    num? parentId,
    String? description,
    num? type,
    String? createdAt,
    String? modifiedAt,
  }) => Category(  id: id ?? _id,
    name: name ?? _name,
    parentId: parentId ?? _parentId,
    description: description ?? _description,
    type: type ?? _type,
    createdAt: createdAt ?? _createdAt,
    modifiedAt: modifiedAt ?? _modifiedAt,
  );
  num? get id => _id;
  String? get name => _name;
  num? get parentId => _parentId;
  String? get description => _description;
  num? get type => _type;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    map['parent_id'] = _parentId;
    map['description'] = _description;
    map['type'] = _type;
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    return map;
  }

}

class Comments {
  Comments({
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
    String? modifiedAt,}){
    _id = id;
    _articleId = articleId;
    _sender = sender;
    _email = email;
    _body = body;
    _replyId = replyId;
    _status = status;
    _reply = reply;
    _replies = replies;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
  }

  Comments.fromJson(dynamic json) {
    _id = json['id'];
    _articleId = json['article_id'];
    _sender = json['sender'];
    _email = json['email'];
    _body = json['body'];
    _replyId = json['reply_id'];
    _status = json['status'];
    _reply = json['reply'];
    if (json['replies'] != null) {
      _replies = [];
      json['replies'].forEach((v) {
        _replies?.add(Replies.fromJson(v));
      });
    }
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }
  num? _id;
  num? _articleId;
  String? _sender;
  String? _email;
  String? _body;
  num? _replyId;
  num? _status;
  dynamic _reply;
  List<Replies>? _replies;
  String? _createdAt;
  String? _modifiedAt;
  Comments copyWith({  num? id,
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
  }) => Comments(  id: id ?? _id,
    articleId: articleId ?? _articleId,
    sender: sender ?? _sender,
    email: email ?? _email,
    body: body ?? _body,
    replyId: replyId ?? _replyId,
    status: status ?? _status,
    reply: reply ?? _reply,
    replies: replies ?? _replies,
    createdAt: createdAt ?? _createdAt,
    modifiedAt: modifiedAt ?? _modifiedAt,
  );
  num? get id => _id;
  num? get articleId => _articleId;
  String? get sender => _sender;
  String? get email => _email;
  String? get body => _body;
  num? get replyId => _replyId;
  num? get status => _status;
  dynamic get reply => _reply;
  List<Replies>? get replies => _replies;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['article_id'] = _articleId;
    map['sender'] = _sender;
    map['email'] = _email;
    map['body'] = _body;
    map['reply_id'] = _replyId;
    map['status'] = _status;
    map['reply'] = _reply;
    if (_replies != null) {
      map['replies'] = _replies?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    return map;
  }

}

class Replies {
  Replies({
    num? id,
    num? articleId,
    String? sender,
    String? email,
    String? body,
    num? replyId,
    num? status,
    String? createdAt,
    String? modifiedAt,}){
    _id = id;
    _articleId = articleId;
    _sender = sender;
    _email = email;
    _body = body;
    _replyId = replyId;
    _status = status;
    _reply = reply;
    _replies = replies;
    _createdAt = createdAt;
    _modifiedAt = modifiedAt;
  }

  Replies.fromJson(dynamic json) {
    _id = json['id'];
    _articleId = json['article_id'];
    _sender = json['sender'];
    _email = json['email'];
    _body = json['body'];
    _replyId = json['reply_id'];
    _status = json['status'];
    _createdAt = json['created_at'];
    _modifiedAt = json['modified_at'];
  }
  num? _id;
  num? _articleId;
  String? _sender;
  String? _email;
  String? _body;
  num? _replyId;
  num? _status;
  dynamic _reply;
  List<dynamic>? _replies;
  String? _createdAt;
  String? _modifiedAt;
  Replies copyWith({  num? id,
    num? articleId,
    String? sender,
    String? email,
    String? body,
    num? replyId,
    num? status,
    dynamic reply,
    List<dynamic>? replies,
    String? createdAt,
    String? modifiedAt,
  }) => Replies(  id: id ?? _id,
    articleId: articleId ?? _articleId,
    sender: sender ?? _sender,
    email: email ?? _email,
    body: body ?? _body,
    replyId: replyId ?? _replyId,
    status: status ?? _status,
    createdAt: createdAt ?? _createdAt,
    modifiedAt: modifiedAt ?? _modifiedAt,
  );
  num? get id => _id;
  num? get articleId => _articleId;
  String? get sender => _sender;
  String? get email => _email;
  String? get body => _body;
  num? get replyId => _replyId;
  num? get status => _status;
  dynamic get reply => _reply;
  List<dynamic>? get replies => _replies;
  String? get createdAt => _createdAt;
  String? get modifiedAt => _modifiedAt;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['article_id'] = _articleId;
    map['sender'] = _sender;
    map['email'] = _email;
    map['body'] = _body;
    map['reply_id'] = _replyId;
    map['status'] = _status;
    map['reply'] = _reply;
    if (_replies != null) {
      map['replies'] = _replies?.map((v) => v.toJson()).toList();
    }
    map['created_at'] = _createdAt;
    map['modified_at'] = _modifiedAt;
    return map;
  }

}