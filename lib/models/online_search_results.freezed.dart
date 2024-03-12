// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'online_search_results.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

OnlineSearchResults _$OnlineSearchResultsFromJson(Map<String, dynamic> json) {
  return _OnlineSearchResults.fromJson(json);
}

/// @nodoc
mixin _$OnlineSearchResults {
  Map<String, List<Category>>? get categories =>
      throw _privateConstructorUsedError;
  int? get count => throw _privateConstructorUsedError;
  Map<String, List<ArticleModel>>? get posts =>
      throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OnlineSearchResultsCopyWith<OnlineSearchResults> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OnlineSearchResultsCopyWith<$Res> {
  factory $OnlineSearchResultsCopyWith(
          OnlineSearchResults value, $Res Function(OnlineSearchResults) then) =
      _$OnlineSearchResultsCopyWithImpl<$Res, OnlineSearchResults>;
  @useResult
  $Res call(
      {Map<String, List<Category>>? categories,
      int? count,
      Map<String, List<ArticleModel>>? posts});
}

/// @nodoc
class _$OnlineSearchResultsCopyWithImpl<$Res, $Val extends OnlineSearchResults>
    implements $OnlineSearchResultsCopyWith<$Res> {
  _$OnlineSearchResultsCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? count = freezed,
    Object? posts = freezed,
  }) {
    return _then(_value.copyWith(
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Category>>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      posts: freezed == posts
          ? _value.posts
          : posts // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ArticleModel>>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$OnlineSearchResultsImplCopyWith<$Res>
    implements $OnlineSearchResultsCopyWith<$Res> {
  factory _$$OnlineSearchResultsImplCopyWith(_$OnlineSearchResultsImpl value,
          $Res Function(_$OnlineSearchResultsImpl) then) =
      __$$OnlineSearchResultsImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {Map<String, List<Category>>? categories,
      int? count,
      Map<String, List<ArticleModel>>? posts});
}

/// @nodoc
class __$$OnlineSearchResultsImplCopyWithImpl<$Res>
    extends _$OnlineSearchResultsCopyWithImpl<$Res, _$OnlineSearchResultsImpl>
    implements _$$OnlineSearchResultsImplCopyWith<$Res> {
  __$$OnlineSearchResultsImplCopyWithImpl(_$OnlineSearchResultsImpl _value,
      $Res Function(_$OnlineSearchResultsImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
    Object? count = freezed,
    Object? posts = freezed,
  }) {
    return _then(_$OnlineSearchResultsImpl(
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as Map<String, List<Category>>?,
      count: freezed == count
          ? _value.count
          : count // ignore: cast_nullable_to_non_nullable
              as int?,
      posts: freezed == posts
          ? _value._posts
          : posts // ignore: cast_nullable_to_non_nullable
              as Map<String, List<ArticleModel>>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$OnlineSearchResultsImpl implements _OnlineSearchResults {
  const _$OnlineSearchResultsImpl(
      {final Map<String, List<Category>>? categories,
      this.count,
      final Map<String, List<ArticleModel>>? posts})
      : _categories = categories,
        _posts = posts;

  factory _$OnlineSearchResultsImpl.fromJson(Map<String, dynamic> json) =>
      _$$OnlineSearchResultsImplFromJson(json);

  final Map<String, List<Category>>? _categories;
  @override
  Map<String, List<Category>>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableMapView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  final int? count;
  final Map<String, List<ArticleModel>>? _posts;
  @override
  Map<String, List<ArticleModel>>? get posts {
    final value = _posts;
    if (value == null) return null;
    if (_posts is EqualUnmodifiableMapView) return _posts;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableMapView(value);
  }

  @override
  String toString() {
    return 'OnlineSearchResults(categories: $categories, count: $count, posts: $posts)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$OnlineSearchResultsImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories) &&
            (identical(other.count, count) || other.count == count) &&
            const DeepCollectionEquality().equals(other._posts, _posts));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(_categories),
      count,
      const DeepCollectionEquality().hash(_posts));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$OnlineSearchResultsImplCopyWith<_$OnlineSearchResultsImpl> get copyWith =>
      __$$OnlineSearchResultsImplCopyWithImpl<_$OnlineSearchResultsImpl>(
          this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$OnlineSearchResultsImplToJson(
      this,
    );
  }
}

abstract class _OnlineSearchResults implements OnlineSearchResults {
  const factory _OnlineSearchResults(
          {final Map<String, List<Category>>? categories,
          final int? count,
          final Map<String, List<ArticleModel>>? posts}) =
      _$OnlineSearchResultsImpl;

  factory _OnlineSearchResults.fromJson(Map<String, dynamic> json) =
      _$OnlineSearchResultsImpl.fromJson;

  @override
  Map<String, List<Category>>? get categories;
  @override
  int? get count;
  @override
  Map<String, List<ArticleModel>>? get posts;
  @override
  @JsonKey(ignore: true)
  _$$OnlineSearchResultsImplCopyWith<_$OnlineSearchResultsImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
