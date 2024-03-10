// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'tree_cat.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

TreeCat _$TreeCatFromJson(Map<String, dynamic> json) {
  return _TreeCat.fromJson(json);
}

/// @nodoc
mixin _$TreeCat {
  List<Category>? get categories => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $TreeCatCopyWith<TreeCat> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $TreeCatCopyWith<$Res> {
  factory $TreeCatCopyWith(TreeCat value, $Res Function(TreeCat) then) =
      _$TreeCatCopyWithImpl<$Res, TreeCat>;
  @useResult
  $Res call({List<Category>? categories});
}

/// @nodoc
class _$TreeCatCopyWithImpl<$Res, $Val extends TreeCat>
    implements $TreeCatCopyWith<$Res> {
  _$TreeCatCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
  }) {
    return _then(_value.copyWith(
      categories: freezed == categories
          ? _value.categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$TreeCatImplCopyWith<$Res> implements $TreeCatCopyWith<$Res> {
  factory _$$TreeCatImplCopyWith(
          _$TreeCatImpl value, $Res Function(_$TreeCatImpl) then) =
      __$$TreeCatImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call({List<Category>? categories});
}

/// @nodoc
class __$$TreeCatImplCopyWithImpl<$Res>
    extends _$TreeCatCopyWithImpl<$Res, _$TreeCatImpl>
    implements _$$TreeCatImplCopyWith<$Res> {
  __$$TreeCatImplCopyWithImpl(
      _$TreeCatImpl _value, $Res Function(_$TreeCatImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? categories = freezed,
  }) {
    return _then(_$TreeCatImpl(
      categories: freezed == categories
          ? _value._categories
          : categories // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$TreeCatImpl implements _TreeCat {
  const _$TreeCatImpl({final List<Category>? categories})
      : _categories = categories;

  factory _$TreeCatImpl.fromJson(Map<String, dynamic> json) =>
      _$$TreeCatImplFromJson(json);

  final List<Category>? _categories;
  @override
  List<Category>? get categories {
    final value = _categories;
    if (value == null) return null;
    if (_categories is EqualUnmodifiableListView) return _categories;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'TreeCat(categories: $categories)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$TreeCatImpl &&
            const DeepCollectionEquality()
                .equals(other._categories, _categories));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType, const DeepCollectionEquality().hash(_categories));

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$TreeCatImplCopyWith<_$TreeCatImpl> get copyWith =>
      __$$TreeCatImplCopyWithImpl<_$TreeCatImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$TreeCatImplToJson(
      this,
    );
  }
}

abstract class _TreeCat implements TreeCat {
  const factory _TreeCat({final List<Category>? categories}) = _$TreeCatImpl;

  factory _TreeCat.fromJson(Map<String, dynamic> json) = _$TreeCatImpl.fromJson;

  @override
  List<Category>? get categories;
  @override
  @JsonKey(ignore: true)
  _$$TreeCatImplCopyWith<_$TreeCatImpl> get copyWith =>
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
  List<Category>? get children => throw _privateConstructorUsedError;

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
      String? modifiedAt,
      List<Category>? children});
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
    Object? children = freezed,
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
      children: freezed == children
          ? _value.children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
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
      String? modifiedAt,
      List<Category>? children});
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
    Object? children = freezed,
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
      children: freezed == children
          ? _value._children
          : children // ignore: cast_nullable_to_non_nullable
              as List<Category>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$CategoryImpl implements _Category {
  const _$CategoryImpl(
      {this.id,
      this.name,
      this.parentId,
      this.description,
      this.type,
      this.createdAt,
      this.modifiedAt,
      final List<Category>? children})
      : _children = children;

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
  final List<Category>? _children;
  @override
  List<Category>? get children {
    final value = _children;
    if (value == null) return null;
    if (_children is EqualUnmodifiableListView) return _children;
    // ignore: implicit_dynamic_type
    return EqualUnmodifiableListView(value);
  }

  @override
  String toString() {
    return 'Category(id: $id, name: $name, parentId: $parentId, description: $description, type: $type, createdAt: $createdAt, modifiedAt: $modifiedAt, children: $children)';
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
                other.modifiedAt == modifiedAt) &&
            const DeepCollectionEquality().equals(other._children, _children));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode => Object.hash(
      runtimeType,
      id,
      name,
      parentId,
      description,
      type,
      createdAt,
      modifiedAt,
      const DeepCollectionEquality().hash(_children));

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
      final String? modifiedAt,
      final List<Category>? children}) = _$CategoryImpl;

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
  List<Category>? get children;
  @override
  @JsonKey(ignore: true)
  _$$CategoryImplCopyWith<_$CategoryImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
