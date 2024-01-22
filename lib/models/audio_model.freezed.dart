// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_model.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

AudioModel _$AudioModelFromJson(Map<String, dynamic> json) {
  return _AudioModel.fromJson(json);
}

/// @nodoc
mixin _$AudioModel {
  num? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  String? get slug => throw _privateConstructorUsedError;
  String? get lang => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  num? get categoryId => throw _privateConstructorUsedError;
  String? get pdfDownloadLink => throw _privateConstructorUsedError;
  String? get docDownloadLink => throw _privateConstructorUsedError;
  String? get mediaDownloadLink => throw _privateConstructorUsedError;
  String? get fileDownloadLink => throw _privateConstructorUsedError;
  String? get coverImage => throw _privateConstructorUsedError;
  num? get visits => throw _privateConstructorUsedError;
  num? get todayVisits => throw _privateConstructorUsedError;
  num? get originalPostId => throw _privateConstructorUsedError;
  num? get status => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get modifiedAt => throw _privateConstructorUsedError;
  String? get edaadDate => throw _privateConstructorUsedError;
  Category? get category => throw _privateConstructorUsedError;
  List<Comments>? get comments => throw _privateConstructorUsedError;
  List<String>? get attachments => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $AudioModelCopyWith<AudioModel> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioModelCopyWith<$Res> {
  factory $AudioModelCopyWith(
          AudioModel value, $Res Function(AudioModel) then) =
      _$AudioModelCopyWithImpl<$Res, AudioModel>;
  @useResult
  $Res call(
      {num? id,
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
      List<String>? attachments});

  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class _$AudioModelCopyWithImpl<$Res, $Val extends AudioModel>
    implements $AudioModelCopyWith<$Res> {
  _$AudioModelCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? lang = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? pdfDownloadLink = freezed,
    Object? docDownloadLink = freezed,
    Object? mediaDownloadLink = freezed,
    Object? fileDownloadLink = freezed,
    Object? coverImage = freezed,
    Object? visits = freezed,
    Object? todayVisits = freezed,
    Object? originalPostId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? edaadDate = freezed,
    Object? category = freezed,
    Object? comments = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as num?,
      pdfDownloadLink: freezed == pdfDownloadLink
          ? _value.pdfDownloadLink
          : pdfDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      docDownloadLink: freezed == docDownloadLink
          ? _value.docDownloadLink
          : docDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaDownloadLink: freezed == mediaDownloadLink
          ? _value.mediaDownloadLink
          : mediaDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      fileDownloadLink: freezed == fileDownloadLink
          ? _value.fileDownloadLink
          : fileDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      visits: freezed == visits
          ? _value.visits
          : visits // ignore: cast_nullable_to_non_nullable
              as num?,
      todayVisits: freezed == todayVisits
          ? _value.todayVisits
          : todayVisits // ignore: cast_nullable_to_non_nullable
              as num?,
      originalPostId: freezed == originalPostId
          ? _value.originalPostId
          : originalPostId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      edaadDate: freezed == edaadDate
          ? _value.edaadDate
          : edaadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      comments: freezed == comments
          ? _value.comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comments>?,
      attachments: freezed == attachments
          ? _value.attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ) as $Val);
  }

  @override
  @pragma('vm:prefer-inline')
  $CategoryCopyWith<$Res>? get category {
    if (_value.category == null) {
      return null;
    }

    return $CategoryCopyWith<$Res>(_value.category!, (value) {
      return _then(_value.copyWith(category: value) as $Val);
    });
  }
}

/// @nodoc
abstract class _$$AudioModelImplCopyWith<$Res>
    implements $AudioModelCopyWith<$Res> {
  factory _$$AudioModelImplCopyWith(
          _$AudioModelImpl value, $Res Function(_$AudioModelImpl) then) =
      __$$AudioModelImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num? id,
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
      List<String>? attachments});

  @override
  $CategoryCopyWith<$Res>? get category;
}

/// @nodoc
class __$$AudioModelImplCopyWithImpl<$Res>
    extends _$AudioModelCopyWithImpl<$Res, _$AudioModelImpl>
    implements _$$AudioModelImplCopyWith<$Res> {
  __$$AudioModelImplCopyWithImpl(
      _$AudioModelImpl _value, $Res Function(_$AudioModelImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? slug = freezed,
    Object? lang = freezed,
    Object? description = freezed,
    Object? categoryId = freezed,
    Object? pdfDownloadLink = freezed,
    Object? docDownloadLink = freezed,
    Object? mediaDownloadLink = freezed,
    Object? fileDownloadLink = freezed,
    Object? coverImage = freezed,
    Object? visits = freezed,
    Object? todayVisits = freezed,
    Object? originalPostId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
    Object? edaadDate = freezed,
    Object? category = freezed,
    Object? comments = freezed,
    Object? attachments = freezed,
  }) {
    return _then(_$AudioModelImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      slug: freezed == slug
          ? _value.slug
          : slug // ignore: cast_nullable_to_non_nullable
              as String?,
      lang: freezed == lang
          ? _value.lang
          : lang // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      categoryId: freezed == categoryId
          ? _value.categoryId
          : categoryId // ignore: cast_nullable_to_non_nullable
              as num?,
      pdfDownloadLink: freezed == pdfDownloadLink
          ? _value.pdfDownloadLink
          : pdfDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      docDownloadLink: freezed == docDownloadLink
          ? _value.docDownloadLink
          : docDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      mediaDownloadLink: freezed == mediaDownloadLink
          ? _value.mediaDownloadLink
          : mediaDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      fileDownloadLink: freezed == fileDownloadLink
          ? _value.fileDownloadLink
          : fileDownloadLink // ignore: cast_nullable_to_non_nullable
              as String?,
      coverImage: freezed == coverImage
          ? _value.coverImage
          : coverImage // ignore: cast_nullable_to_non_nullable
              as String?,
      visits: freezed == visits
          ? _value.visits
          : visits // ignore: cast_nullable_to_non_nullable
              as num?,
      todayVisits: freezed == todayVisits
          ? _value.todayVisits
          : todayVisits // ignore: cast_nullable_to_non_nullable
              as num?,
      originalPostId: freezed == originalPostId
          ? _value.originalPostId
          : originalPostId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
      edaadDate: freezed == edaadDate
          ? _value.edaadDate
          : edaadDate // ignore: cast_nullable_to_non_nullable
              as String?,
      category: freezed == category
          ? _value.category
          : category // ignore: cast_nullable_to_non_nullable
              as Category?,
      comments: freezed == comments
          ? _value._comments
          : comments // ignore: cast_nullable_to_non_nullable
              as List<Comments>?,
      attachments: freezed == attachments
          ? _value._attachments
          : attachments // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$AudioModelImpl with DiagnosticableTreeMixin implements _AudioModel {
  const _$AudioModelImpl(
      {this.id,
      this.name,
      this.slug,
      this.lang,
      this.description,
      this.categoryId,
      this.pdfDownloadLink,
      this.docDownloadLink,
      this.mediaDownloadLink,
      this.fileDownloadLink,
      this.coverImage,
      this.visits,
      this.todayVisits,
      this.originalPostId,
      this.status,
      this.createdAt,
      this.modifiedAt,
      this.edaadDate,
      this.category,
      final List<Comments>? comments,
      final List<String>? attachments})
      : _comments = comments,
        _attachments = attachments;

  factory _$AudioModelImpl.fromJson(Map<String, dynamic> json) =>
      _$$AudioModelImplFromJson(json);

  @override
  final num? id;
  @override
  final String? name;
  @override
  final String? slug;
  @override
  final String? lang;
  @override
  final String? description;
  @override
  final num? categoryId;
  @override
  final String? pdfDownloadLink;
  @override
  final String? docDownloadLink;
  @override
  final String? mediaDownloadLink;
  @override
  final String? fileDownloadLink;
  @override
  final String? coverImage;
  @override
  final num? visits;
  @override
  final num? todayVisits;
  @override
  final num? originalPostId;
  @override
  final num? status;
  @override
  final String? createdAt;
  @override
  final String? modifiedAt;
  @override
  final String? edaadDate;
  @override
  final Category? category;
  final List<Comments>? _comments;
  @override
  List<Comments>? get comments {
    final value = _comments;
    if (value == null) return null;
    if (_comments is EqualUnmodifiableListView) return _comments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  final List<String>? _attachments;
  @override
  List<String>? get attachments {
    final value = _attachments;
    if (value == null) return null;
    if (_attachments is EqualUnmodifiableListView) return _attachments;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'AudioModel(id: $id, name: $name, slug: $slug, lang: $lang, description: $description, categoryId: $categoryId, pdfDownloadLink: $pdfDownloadLink, docDownloadLink: $docDownloadLink, mediaDownloadLink: $mediaDownloadLink, fileDownloadLink: $fileDownloadLink, coverImage: $coverImage, visits: $visits, todayVisits: $todayVisits, originalPostId: $originalPostId, status: $status, createdAt: $createdAt, modifiedAt: $modifiedAt, edaadDate: $edaadDate, category: $category, comments: $comments, attachments: $attachments)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'AudioModel'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('slug', slug))
      ..add(DiagnosticsProperty('lang', lang))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('categoryId', categoryId))
      ..add(DiagnosticsProperty('pdfDownloadLink', pdfDownloadLink))
      ..add(DiagnosticsProperty('docDownloadLink', docDownloadLink))
      ..add(DiagnosticsProperty('mediaDownloadLink', mediaDownloadLink))
      ..add(DiagnosticsProperty('fileDownloadLink', fileDownloadLink))
      ..add(DiagnosticsProperty('coverImage', coverImage))
      ..add(DiagnosticsProperty('visits', visits))
      ..add(DiagnosticsProperty('todayVisits', todayVisits))
      ..add(DiagnosticsProperty('originalPostId', originalPostId))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('modifiedAt', modifiedAt))
      ..add(DiagnosticsProperty('edaadDate', edaadDate))
      ..add(DiagnosticsProperty('category', category))
      ..add(DiagnosticsProperty('comments', comments))
      ..add(DiagnosticsProperty('attachments', attachments));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioModelImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.slug, slug) || other.slug == slug) &&
            (identical(other.lang, lang) || other.lang == lang) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.categoryId, categoryId) ||
                other.categoryId == categoryId) &&
            (identical(other.pdfDownloadLink, pdfDownloadLink) ||
                other.pdfDownloadLink == pdfDownloadLink) &&
            (identical(other.docDownloadLink, docDownloadLink) ||
                other.docDownloadLink == docDownloadLink) &&
            (identical(other.mediaDownloadLink, mediaDownloadLink) ||
                other.mediaDownloadLink == mediaDownloadLink) &&
            (identical(other.fileDownloadLink, fileDownloadLink) ||
                other.fileDownloadLink == fileDownloadLink) &&
            (identical(other.coverImage, coverImage) ||
                other.coverImage == coverImage) &&
            (identical(other.visits, visits) || other.visits == visits) &&
            (identical(other.todayVisits, todayVisits) ||
                other.todayVisits == todayVisits) &&
            (identical(other.originalPostId, originalPostId) ||
                other.originalPostId == originalPostId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt) &&
            (identical(other.edaadDate, edaadDate) ||
                other.edaadDate == edaadDate) &&
            (identical(other.category, category) ||
                other.category == category) &&
            const DeepCollectionEquality().equals(other._comments, _comments) &&
            const DeepCollectionEquality()
                .equals(other._attachments, _attachments));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hashAll([
        runtimeType,
        id,
        name,
        slug,
        lang,
        description,
        categoryId,
        pdfDownloadLink,
        docDownloadLink,
        mediaDownloadLink,
        fileDownloadLink,
        coverImage,
        visits,
        todayVisits,
        originalPostId,
        status,
        createdAt,
        modifiedAt,
        edaadDate,
        category,
        const DeepCollectionEquality().hash(_comments),
        const DeepCollectionEquality().hash(_attachments)
      ]);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioModelImplCopyWith<_$AudioModelImpl> get copyWith =>
      __$$AudioModelImplCopyWithImpl<_$AudioModelImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$AudioModelImplToJson(
      this,
    );
  }
}

abstract class _AudioModel implements AudioModel {
  const factory _AudioModel(
      {final num? id,
      final String? name,
      final String? slug,
      final String? lang,
      final String? description,
      final num? categoryId,
      final String? pdfDownloadLink,
      final String? docDownloadLink,
      final String? mediaDownloadLink,
      final String? fileDownloadLink,
      final String? coverImage,
      final num? visits,
      final num? todayVisits,
      final num? originalPostId,
      final num? status,
      final String? createdAt,
      final String? modifiedAt,
      final String? edaadDate,
      final Category? category,
      final List<Comments>? comments,
      final List<String>? attachments}) = _$AudioModelImpl;

  factory _AudioModel.fromJson(Map<String, dynamic> json) =
      _$AudioModelImpl.fromJson;

  @override
  num? get id;
  @override
  String? get name;
  @override
  String? get slug;
  @override
  String? get lang;
  @override
  String? get description;
  @override
  num? get categoryId;
  @override
  String? get pdfDownloadLink;
  @override
  String? get docDownloadLink;
  @override
  String? get mediaDownloadLink;
  @override
  String? get fileDownloadLink;
  @override
  String? get coverImage;
  @override
  num? get visits;
  @override
  num? get todayVisits;
  @override
  num? get originalPostId;
  @override
  num? get status;
  @override
  String? get createdAt;
  @override
  String? get modifiedAt;
  @override
  String? get edaadDate;
  @override
  Category? get category;
  @override
  List<Comments>? get comments;
  @override
  List<String>? get attachments;
  @override
  @JsonKey(ignore: true)
  _$$AudioModelImplCopyWith<_$AudioModelImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Category _$CategoryFromJson(Map<String, dynamic> json) {
  return _Category.fromJson(json);
}

/// @nodoc
mixin _$Category {
  num? get id => throw _privateConstructorUsedError;
  String? get name => throw _privateConstructorUsedError;
  num? get parentId => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  num? get type => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get modifiedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CategoryCopyWith<Category> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CategoryCopyWith<$Res> {
  factory $CategoryCopyWith(Category value, $Res Function(Category) then) =
      _$CategoryCopyWithImpl<$Res, Category>;
  @useResult
  $Res call(
      {num? id,
      String? name,
      num? parentId,
      String? description,
      num? type,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class _$CategoryCopyWithImpl<$Res, $Val extends Category>
    implements $CategoryCopyWith<$Res> {
  _$CategoryCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as num?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CategoryImplCopyWith<$Res>
    implements $CategoryCopyWith<$Res> {
  factory _$$CategoryImplCopyWith(
          _$CategoryImpl value, $Res Function(_$CategoryImpl) then) =
      __$$CategoryImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num? id,
      String? name,
      num? parentId,
      String? description,
      num? type,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class __$$CategoryImplCopyWithImpl<$Res>
    extends _$CategoryCopyWithImpl<$Res, _$CategoryImpl>
    implements _$$CategoryImplCopyWith<$Res> {
  __$$CategoryImplCopyWithImpl(
      _$CategoryImpl _value, $Res Function(_$CategoryImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? name = freezed,
    Object? parentId = freezed,
    Object? description = freezed,
    Object? type = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_$CategoryImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      name: freezed == name
          ? _value.name
          : name // ignore: cast_nullable_to_non_nullable
              as String?,
      parentId: freezed == parentId
          ? _value.parentId
          : parentId // ignore: cast_nullable_to_non_nullable
              as num?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      type: freezed == type
          ? _value.type
          : type // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl with DiagnosticableTreeMixin implements _Category {
  const _$CategoryImpl(
      {this.id,
      this.name,
      this.parentId,
      this.description,
      this.type,
      this.createdAt,
      this.modifiedAt});

  factory _$CategoryImpl.fromJson(Map<String, dynamic> json) =>
      _$$CategoryImplFromJson(json);

  @override
  final num? id;
  @override
  final String? name;
  @override
  final num? parentId;
  @override
  final String? description;
  @override
  final num? type;
  @override
  final String? createdAt;
  @override
  final String? modifiedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Category(id: $id, name: $name, parentId: $parentId, description: $description, type: $type, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Category'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('name', name))
      ..add(DiagnosticsProperty('parentId', parentId))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('type', type))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('modifiedAt', modifiedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CategoryImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.name, name) || other.name == name) &&
            (identical(other.parentId, parentId) ||
                other.parentId == parentId) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.type, type) || other.type == type) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, name, parentId, description,
      type, createdAt, modifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      __$$CategoryImplCopyWithImpl<_$CategoryImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CategoryImplToJson(
      this,
    );
  }
}

abstract class _Category implements Category {
  const factory _Category(
      {final num? id,
      final String? name,
      final num? parentId,
      final String? description,
      final num? type,
      final String? createdAt,
      final String? modifiedAt}) = _$CategoryImpl;

  factory _Category.fromJson(Map<String, dynamic> json) =
      _$CategoryImpl.fromJson;

  @override
  num? get id;
  @override
  String? get name;
  @override
  num? get parentId;
  @override
  String? get description;
  @override
  num? get type;
  @override
  String? get createdAt;
  @override
  String? get modifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Comments _$CommentsFromJson(Map<String, dynamic> json) {
  return _Comments.fromJson(json);
}

/// @nodoc
mixin _$Comments {
  num? get id => throw _privateConstructorUsedError;
  num? get articleId => throw _privateConstructorUsedError;
  String? get sender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  num? get replyId => throw _privateConstructorUsedError;
  num? get status => throw _privateConstructorUsedError;
  dynamic get reply => throw _privateConstructorUsedError;
  List<Replies>? get replies => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get modifiedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $CommentsCopyWith<Comments> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $CommentsCopyWith<$Res> {
  factory $CommentsCopyWith(Comments value, $Res Function(Comments) then) =
      _$CommentsCopyWithImpl<$Res, Comments>;
  @useResult
  $Res call(
      {num? id,
      num? articleId,
      String? sender,
      String? email,
      String? body,
      num? replyId,
      num? status,
      dynamic reply,
      List<Replies>? replies,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class _$CommentsCopyWithImpl<$Res, $Val extends Comments>
    implements $CommentsCopyWith<$Res> {
  _$CommentsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? articleId = freezed,
    Object? sender = freezed,
    Object? email = freezed,
    Object? body = freezed,
    Object? replyId = freezed,
    Object? status = freezed,
    Object? reply = freezed,
    Object? replies = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as num?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replies: freezed == replies
          ? _value.replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Replies>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$CommentsImplCopyWith<$Res>
    implements $CommentsCopyWith<$Res> {
  factory _$$CommentsImplCopyWith(
          _$CommentsImpl value, $Res Function(_$CommentsImpl) then) =
      __$$CommentsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num? id,
      num? articleId,
      String? sender,
      String? email,
      String? body,
      num? replyId,
      num? status,
      dynamic reply,
      List<Replies>? replies,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class __$$CommentsImplCopyWithImpl<$Res>
    extends _$CommentsCopyWithImpl<$Res, _$CommentsImpl>
    implements _$$CommentsImplCopyWith<$Res> {
  __$$CommentsImplCopyWithImpl(
      _$CommentsImpl _value, $Res Function(_$CommentsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? articleId = freezed,
    Object? sender = freezed,
    Object? email = freezed,
    Object? body = freezed,
    Object? replyId = freezed,
    Object? status = freezed,
    Object? reply = freezed,
    Object? replies = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_$CommentsImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as num?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      reply: freezed == reply
          ? _value.reply
          : reply // ignore: cast_nullable_to_non_nullable
              as dynamic,
      replies: freezed == replies
          ? _value._replies
          : replies // ignore: cast_nullable_to_non_nullable
              as List<Replies>?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CommentsImpl with DiagnosticableTreeMixin implements _Comments {
  const _$CommentsImpl(
      {this.id,
      this.articleId,
      this.sender,
      this.email,
      this.body,
      this.replyId,
      this.status,
      this.reply,
      final List<Replies>? replies,
      this.createdAt,
      this.modifiedAt})
      : _replies = replies;

  factory _$CommentsImpl.fromJson(Map<String, dynamic> json) =>
      _$$CommentsImplFromJson(json);

  @override
  final num? id;
  @override
  final num? articleId;
  @override
  final String? sender;
  @override
  final String? email;
  @override
  final String? body;
  @override
  final num? replyId;
  @override
  final num? status;
  @override
  final dynamic reply;
  final List<Replies>? _replies;
  @override
  List<Replies>? get replies {
    final value = _replies;
    if (value == null) return null;
    if (_replies is EqualUnmodifiableListView) return _replies;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  final String? createdAt;
  @override
  final String? modifiedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Comments(id: $id, articleId: $articleId, sender: $sender, email: $email, body: $body, replyId: $replyId, status: $status, reply: $reply, replies: $replies, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Comments'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('articleId', articleId))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('replyId', replyId))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('reply', reply))
      ..add(DiagnosticsProperty('replies', replies))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('modifiedAt', modifiedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$CommentsImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.status, status) || other.status == status) &&
            const DeepCollectionEquality().equals(other.reply, reply) &&
            const DeepCollectionEquality().equals(other._replies, _replies) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      articleId,
      sender,
      email,
      body,
      replyId,
      status,
      const DeepCollectionEquality().hash(reply),
      const DeepCollectionEquality().hash(_replies),
      createdAt,
      modifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$CommentsImplCopyWith<_$CommentsImpl> get copyWith =>
      __$$CommentsImplCopyWithImpl<_$CommentsImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$CommentsImplToJson(
      this,
    );
  }
}

abstract class _Comments implements Comments {
  const factory _Comments(
      {final num? id,
      final num? articleId,
      final String? sender,
      final String? email,
      final String? body,
      final num? replyId,
      final num? status,
      final dynamic reply,
      final List<Replies>? replies,
      final String? createdAt,
      final String? modifiedAt}) = _$CommentsImpl;

  factory _Comments.fromJson(Map<String, dynamic> json) =
      _$CommentsImpl.fromJson;

  @override
  num? get id;
  @override
  num? get articleId;
  @override
  String? get sender;
  @override
  String? get email;
  @override
  String? get body;
  @override
  num? get replyId;
  @override
  num? get status;
  @override
  dynamic get reply;
  @override
  List<Replies>? get replies;
  @override
  String? get createdAt;
  @override
  String? get modifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$CommentsImplCopyWith<_$CommentsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

Replies _$RepliesFromJson(Map<String, dynamic> json) {
  return _Replies.fromJson(json);
}

/// @nodoc
mixin _$Replies {
  num? get id => throw _privateConstructorUsedError;
  num? get articleId => throw _privateConstructorUsedError;
  String? get sender => throw _privateConstructorUsedError;
  String? get email => throw _privateConstructorUsedError;
  String? get body => throw _privateConstructorUsedError;
  num? get replyId => throw _privateConstructorUsedError;
  num? get status => throw _privateConstructorUsedError;
  String? get createdAt => throw _privateConstructorUsedError;
  String? get modifiedAt => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $RepliesCopyWith<Replies> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $RepliesCopyWith<$Res> {
  factory $RepliesCopyWith(Replies value, $Res Function(Replies) then) =
      _$RepliesCopyWithImpl<$Res, Replies>;
  @useResult
  $Res call(
      {num? id,
      num? articleId,
      String? sender,
      String? email,
      String? body,
      num? replyId,
      num? status,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class _$RepliesCopyWithImpl<$Res, $Val extends Replies>
    implements $RepliesCopyWith<$Res> {
  _$RepliesCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? articleId = freezed,
    Object? sender = freezed,
    Object? email = freezed,
    Object? body = freezed,
    Object? replyId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as num?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$RepliesImplCopyWith<$Res> implements $RepliesCopyWith<$Res> {
  factory _$$RepliesImplCopyWith(
          _$RepliesImpl value, $Res Function(_$RepliesImpl) then) =
      __$$RepliesImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {num? id,
      num? articleId,
      String? sender,
      String? email,
      String? body,
      num? replyId,
      num? status,
      String? createdAt,
      String? modifiedAt});
}

/// @nodoc
class __$$RepliesImplCopyWithImpl<$Res>
    extends _$RepliesCopyWithImpl<$Res, _$RepliesImpl>
    implements _$$RepliesImplCopyWith<$Res> {
  __$$RepliesImplCopyWithImpl(
      _$RepliesImpl _value, $Res Function(_$RepliesImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? articleId = freezed,
    Object? sender = freezed,
    Object? email = freezed,
    Object? body = freezed,
    Object? replyId = freezed,
    Object? status = freezed,
    Object? createdAt = freezed,
    Object? modifiedAt = freezed,
  }) {
    return _then(_$RepliesImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as num?,
      articleId: freezed == articleId
          ? _value.articleId
          : articleId // ignore: cast_nullable_to_non_nullable
              as num?,
      sender: freezed == sender
          ? _value.sender
          : sender // ignore: cast_nullable_to_non_nullable
              as String?,
      email: freezed == email
          ? _value.email
          : email // ignore: cast_nullable_to_non_nullable
              as String?,
      body: freezed == body
          ? _value.body
          : body // ignore: cast_nullable_to_non_nullable
              as String?,
      replyId: freezed == replyId
          ? _value.replyId
          : replyId // ignore: cast_nullable_to_non_nullable
              as num?,
      status: freezed == status
          ? _value.status
          : status // ignore: cast_nullable_to_non_nullable
              as num?,
      createdAt: freezed == createdAt
          ? _value.createdAt
          : createdAt // ignore: cast_nullable_to_non_nullable
              as String?,
      modifiedAt: freezed == modifiedAt
          ? _value.modifiedAt
          : modifiedAt // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$RepliesImpl with DiagnosticableTreeMixin implements _Replies {
  const _$RepliesImpl(
      {this.id,
      this.articleId,
      this.sender,
      this.email,
      this.body,
      this.replyId,
      this.status,
      this.createdAt,
      this.modifiedAt});

  factory _$RepliesImpl.fromJson(Map<String, dynamic> json) =>
      _$$RepliesImplFromJson(json);

  @override
  final num? id;
  @override
  final num? articleId;
  @override
  final String? sender;
  @override
  final String? email;
  @override
  final String? body;
  @override
  final num? replyId;
  @override
  final num? status;
  @override
  final String? createdAt;
  @override
  final String? modifiedAt;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Replies(id: $id, articleId: $articleId, sender: $sender, email: $email, body: $body, replyId: $replyId, status: $status, createdAt: $createdAt, modifiedAt: $modifiedAt)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Replies'))
      ..add(DiagnosticsProperty('id', id))
      ..add(DiagnosticsProperty('articleId', articleId))
      ..add(DiagnosticsProperty('sender', sender))
      ..add(DiagnosticsProperty('email', email))
      ..add(DiagnosticsProperty('body', body))
      ..add(DiagnosticsProperty('replyId', replyId))
      ..add(DiagnosticsProperty('status', status))
      ..add(DiagnosticsProperty('createdAt', createdAt))
      ..add(DiagnosticsProperty('modifiedAt', modifiedAt));
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$RepliesImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.articleId, articleId) ||
                other.articleId == articleId) &&
            (identical(other.sender, sender) || other.sender == sender) &&
            (identical(other.email, email) || other.email == email) &&
            (identical(other.body, body) || other.body == body) &&
            (identical(other.replyId, replyId) || other.replyId == replyId) &&
            (identical(other.status, status) || other.status == status) &&
            (identical(other.createdAt, createdAt) ||
                other.createdAt == createdAt) &&
            (identical(other.modifiedAt, modifiedAt) ||
                other.modifiedAt == modifiedAt));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(runtimeType, id, articleId, sender, email,
      body, replyId, status, createdAt, modifiedAt);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$RepliesImplCopyWith<_$RepliesImpl> get copyWith =>
      __$$RepliesImplCopyWithImpl<_$RepliesImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$RepliesImplToJson(
      this,
    );
  }
}

abstract class _Replies implements Replies {
  const factory _Replies(
      {final num? id,
      final num? articleId,
      final String? sender,
      final String? email,
      final String? body,
      final num? replyId,
      final num? status,
      final String? createdAt,
      final String? modifiedAt}) = _$RepliesImpl;

  factory _Replies.fromJson(Map<String, dynamic> json) = _$RepliesImpl.fromJson;

  @override
  num? get id;
  @override
  num? get articleId;
  @override
  String? get sender;
  @override
  String? get email;
  @override
  String? get body;
  @override
  num? get replyId;
  @override
  num? get status;
  @override
  String? get createdAt;
  @override
  String? get modifiedAt;
  @override
  @JsonKey(ignore: true)
  _$$RepliesImplCopyWith<_$RepliesImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
