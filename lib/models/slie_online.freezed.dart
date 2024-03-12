// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'slie_online.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

SlideOnline _$SlideOnlineFromJson(Map<String, dynamic> json) {
  return _SlideOnline.fromJson(json);
}

/// @nodoc
mixin _$SlideOnline {
  int? get id => throw _privateConstructorUsedError;
  int? get priority => throw _privateConstructorUsedError;
  String? get title => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get url => throw _privateConstructorUsedError;
  String? get link => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $SlideOnlineCopyWith<SlideOnline> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $SlideOnlineCopyWith<$Res> {
  factory $SlideOnlineCopyWith(
          SlideOnline value, $Res Function(SlideOnline) then) =
      _$SlideOnlineCopyWithImpl<$Res, SlideOnline>;
  @useResult
  $Res call(
      {int? id,
      int? priority,
      String? title,
      String? description,
      String? url,
      String? link});
}

/// @nodoc
class _$SlideOnlineCopyWithImpl<$Res, $Val extends SlideOnline>
    implements $SlideOnlineCopyWith<$Res> {
  _$SlideOnlineCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? link = freezed,
  }) {
    return _then(_value.copyWith(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ) as $Val);
  }
}

/// @nodoc
abstract class _$$SlideOnlineImplCopyWith<$Res>
    implements $SlideOnlineCopyWith<$Res> {
  factory _$$SlideOnlineImplCopyWith(
          _$SlideOnlineImpl value, $Res Function(_$SlideOnlineImpl) then) =
      __$$SlideOnlineImplCopyWithImpl<$Res>;
  @override
  @useResult
  $Res call(
      {int? id,
      int? priority,
      String? title,
      String? description,
      String? url,
      String? link});
}

/// @nodoc
class __$$SlideOnlineImplCopyWithImpl<$Res>
    extends _$SlideOnlineCopyWithImpl<$Res, _$SlideOnlineImpl>
    implements _$$SlideOnlineImplCopyWith<$Res> {
  __$$SlideOnlineImplCopyWithImpl(
      _$SlideOnlineImpl _value, $Res Function(_$SlideOnlineImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? id = freezed,
    Object? priority = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? url = freezed,
    Object? link = freezed,
  }) {
    return _then(_$SlideOnlineImpl(
      id: freezed == id
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as int?,
      priority: freezed == priority
          ? _value.priority
          : priority // ignore: cast_nullable_to_non_nullable
              as int?,
      title: freezed == title
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String?,
      description: freezed == description
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      url: freezed == url
          ? _value.url
          : url // ignore: cast_nullable_to_non_nullable
              as String?,
      link: freezed == link
          ? _value.link
          : link // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$SlideOnlineImpl implements _SlideOnline {
  const _$SlideOnlineImpl(
      {this.id,
      this.priority,
      this.title,
      this.description,
      this.url,
      this.link});

  factory _$SlideOnlineImpl.fromJson(Map<String, dynamic> json) =>
      _$$SlideOnlineImplFromJson(json);

  @override
  final int? id;
  @override
  final int? priority;
  @override
  final String? title;
  @override
  final String? description;
  @override
  final String? url;
  @override
  final String? link;

  @override
  String toString() {
    return 'SlideOnline(id: $id, priority: $priority, title: $title, description: $description, url: $url, link: $link)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$SlideOnlineImpl &&
            (identical(other.id, id) || other.id == id) &&
            (identical(other.priority, priority) ||
                other.priority == priority) &&
            (identical(other.title, title) || other.title == title) &&
            (identical(other.description, description) ||
                other.description == description) &&
            (identical(other.url, url) || other.url == url) &&
            (identical(other.link, link) || other.link == link));
  }

  @JsonKey(ignore: true)
  @override
  int get hashCode =>
      Object.hash(runtimeType, id, priority, title, description, url, link);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$SlideOnlineImplCopyWith<_$SlideOnlineImpl> get copyWith =>
      __$$SlideOnlineImplCopyWithImpl<_$SlideOnlineImpl>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$SlideOnlineImplToJson(
      this,
    );
  }
}

abstract class _SlideOnline implements SlideOnline {
  const factory _SlideOnline(
      {final int? id,
      final int? priority,
      final String? title,
      final String? description,
      final String? url,
      final String? link}) = _$SlideOnlineImpl;

  factory _SlideOnline.fromJson(Map<String, dynamic> json) =
      _$SlideOnlineImpl.fromJson;

  @override
  int? get id;
  @override
  int? get priority;
  @override
  String? get title;
  @override
  String? get description;
  @override
  String? get url;
  @override
  String? get link;
  @override
  @JsonKey(ignore: true)
  _$$SlideOnlineImplCopyWith<_$SlideOnlineImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
