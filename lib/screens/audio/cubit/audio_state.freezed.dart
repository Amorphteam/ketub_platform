// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'audio_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more information: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

/// @nodoc
mixin _$AudioState {
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AudioModel audioModel) loaded,
    required TResult Function(String message) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AudioModel audioModel)? loaded,
    TResult? Function(String message)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AudioModel audioModel)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioInitialState value) initial,
    required TResult Function(AudioLoadingState value) loading,
    required TResult Function(AudioLoadedState value) loaded,
    required TResult Function(AudioErrorState value) error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioInitialState value)? initial,
    TResult? Function(AudioLoadingState value)? loading,
    TResult? Function(AudioLoadedState value)? loaded,
    TResult? Function(AudioErrorState value)? error,
  }) =>
      throw _privateConstructorUsedError;
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioInitialState value)? initial,
    TResult Function(AudioLoadingState value)? loading,
    TResult Function(AudioLoadedState value)? loaded,
    TResult Function(AudioErrorState value)? error,
    required TResult orElse(),
  }) =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $AudioStateCopyWith<$Res> {
  factory $AudioStateCopyWith(
          AudioState value, $Res Function(AudioState) then) =
      _$AudioStateCopyWithImpl<$Res, AudioState>;
}

/// @nodoc
class _$AudioStateCopyWithImpl<$Res, $Val extends AudioState>
    implements $AudioStateCopyWith<$Res> {
  _$AudioStateCopyWithImpl(this._value, this._then);

  // ignore: unused_field
  final $Val _value;
  // ignore: unused_field
  final $Res Function($Val) _then;
}

/// @nodoc
abstract class _$$AudioInitialStateImplCopyWith<$Res> {
  factory _$$AudioInitialStateImplCopyWith(_$AudioInitialStateImpl value,
          $Res Function(_$AudioInitialStateImpl) then) =
      __$$AudioInitialStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AudioInitialStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioInitialStateImpl>
    implements _$$AudioInitialStateImplCopyWith<$Res> {
  __$$AudioInitialStateImplCopyWithImpl(_$AudioInitialStateImpl _value,
      $Res Function(_$AudioInitialStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AudioInitialStateImpl implements AudioInitialState {
  const _$AudioInitialStateImpl();

  @override
  String toString() {
    return 'AudioState.initial()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AudioInitialStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AudioModel audioModel) loaded,
    required TResult Function(String message) error,
  }) {
    return initial();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AudioModel audioModel)? loaded,
    TResult? Function(String message)? error,
  }) {
    return initial?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AudioModel audioModel)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioInitialState value) initial,
    required TResult Function(AudioLoadingState value) loading,
    required TResult Function(AudioLoadedState value) loaded,
    required TResult Function(AudioErrorState value) error,
  }) {
    return initial(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioInitialState value)? initial,
    TResult? Function(AudioLoadingState value)? loading,
    TResult? Function(AudioLoadedState value)? loaded,
    TResult? Function(AudioErrorState value)? error,
  }) {
    return initial?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioInitialState value)? initial,
    TResult Function(AudioLoadingState value)? loading,
    TResult Function(AudioLoadedState value)? loaded,
    TResult Function(AudioErrorState value)? error,
    required TResult orElse(),
  }) {
    if (initial != null) {
      return initial(this);
    }
    return orElse();
  }
}

abstract class AudioInitialState implements AudioState {
  const factory AudioInitialState() = _$AudioInitialStateImpl;
}

/// @nodoc
abstract class _$$AudioLoadingStateImplCopyWith<$Res> {
  factory _$$AudioLoadingStateImplCopyWith(_$AudioLoadingStateImpl value,
          $Res Function(_$AudioLoadingStateImpl) then) =
      __$$AudioLoadingStateImplCopyWithImpl<$Res>;
}

/// @nodoc
class __$$AudioLoadingStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioLoadingStateImpl>
    implements _$$AudioLoadingStateImplCopyWith<$Res> {
  __$$AudioLoadingStateImplCopyWithImpl(_$AudioLoadingStateImpl _value,
      $Res Function(_$AudioLoadingStateImpl) _then)
      : super(_value, _then);
}

/// @nodoc

class _$AudioLoadingStateImpl implements AudioLoadingState {
  const _$AudioLoadingStateImpl();

  @override
  String toString() {
    return 'AudioState.loading()';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType && other is _$AudioLoadingStateImpl);
  }

  @override
  int get hashCode => runtimeType.hashCode;

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AudioModel audioModel) loaded,
    required TResult Function(String message) error,
  }) {
    return loading();
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AudioModel audioModel)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loading?.call();
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AudioModel audioModel)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading();
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioInitialState value) initial,
    required TResult Function(AudioLoadingState value) loading,
    required TResult Function(AudioLoadedState value) loaded,
    required TResult Function(AudioErrorState value) error,
  }) {
    return loading(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioInitialState value)? initial,
    TResult? Function(AudioLoadingState value)? loading,
    TResult? Function(AudioLoadedState value)? loaded,
    TResult? Function(AudioErrorState value)? error,
  }) {
    return loading?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioInitialState value)? initial,
    TResult Function(AudioLoadingState value)? loading,
    TResult Function(AudioLoadedState value)? loaded,
    TResult Function(AudioErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loading != null) {
      return loading(this);
    }
    return orElse();
  }
}

abstract class AudioLoadingState implements AudioState {
  const factory AudioLoadingState() = _$AudioLoadingStateImpl;
}

/// @nodoc
abstract class _$$AudioLoadedStateImplCopyWith<$Res> {
  factory _$$AudioLoadedStateImplCopyWith(_$AudioLoadedStateImpl value,
          $Res Function(_$AudioLoadedStateImpl) then) =
      __$$AudioLoadedStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({AudioModel audioModel});

  $AudioModelCopyWith<$Res> get audioModel;
}

/// @nodoc
class __$$AudioLoadedStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioLoadedStateImpl>
    implements _$$AudioLoadedStateImplCopyWith<$Res> {
  __$$AudioLoadedStateImplCopyWithImpl(_$AudioLoadedStateImpl _value,
      $Res Function(_$AudioLoadedStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? audioModel = null,
  }) {
    return _then(_$AudioLoadedStateImpl(
      null == audioModel
          ? _value.audioModel
          : audioModel // ignore: cast_nullable_to_non_nullable
              as AudioModel,
    ));
  }

  @override
  @pragma('vm:prefer-inline')
  $AudioModelCopyWith<$Res> get audioModel {
    return $AudioModelCopyWith<$Res>(_value.audioModel, (value) {
      return _then(_value.copyWith(audioModel: value));
    });
  }
}

/// @nodoc

class _$AudioLoadedStateImpl implements AudioLoadedState {
  const _$AudioLoadedStateImpl(this.audioModel);

  @override
  final AudioModel audioModel;

  @override
  String toString() {
    return 'AudioState.loaded(audioModel: $audioModel)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioLoadedStateImpl &&
            (identical(other.audioModel, audioModel) ||
                other.audioModel == audioModel));
  }

  @override
  int get hashCode => Object.hash(runtimeType, audioModel);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioLoadedStateImplCopyWith<_$AudioLoadedStateImpl> get copyWith =>
      __$$AudioLoadedStateImplCopyWithImpl<_$AudioLoadedStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AudioModel audioModel) loaded,
    required TResult Function(String message) error,
  }) {
    return loaded(audioModel);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AudioModel audioModel)? loaded,
    TResult? Function(String message)? error,
  }) {
    return loaded?.call(audioModel);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AudioModel audioModel)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(audioModel);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioInitialState value) initial,
    required TResult Function(AudioLoadingState value) loading,
    required TResult Function(AudioLoadedState value) loaded,
    required TResult Function(AudioErrorState value) error,
  }) {
    return loaded(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioInitialState value)? initial,
    TResult? Function(AudioLoadingState value)? loading,
    TResult? Function(AudioLoadedState value)? loaded,
    TResult? Function(AudioErrorState value)? error,
  }) {
    return loaded?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioInitialState value)? initial,
    TResult Function(AudioLoadingState value)? loading,
    TResult Function(AudioLoadedState value)? loaded,
    TResult Function(AudioErrorState value)? error,
    required TResult orElse(),
  }) {
    if (loaded != null) {
      return loaded(this);
    }
    return orElse();
  }
}

abstract class AudioLoadedState implements AudioState {
  const factory AudioLoadedState(final AudioModel audioModel) =
      _$AudioLoadedStateImpl;

  AudioModel get audioModel;
  @JsonKey(ignore: true)
  _$$AudioLoadedStateImplCopyWith<_$AudioLoadedStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class _$$AudioErrorStateImplCopyWith<$Res> {
  factory _$$AudioErrorStateImplCopyWith(_$AudioErrorStateImpl value,
          $Res Function(_$AudioErrorStateImpl) then) =
      __$$AudioErrorStateImplCopyWithImpl<$Res>;
  @useResult
  $Res call({String message});
}

/// @nodoc
class __$$AudioErrorStateImplCopyWithImpl<$Res>
    extends _$AudioStateCopyWithImpl<$Res, _$AudioErrorStateImpl>
    implements _$$AudioErrorStateImplCopyWith<$Res> {
  __$$AudioErrorStateImplCopyWithImpl(
      _$AudioErrorStateImpl _value, $Res Function(_$AudioErrorStateImpl) _then)
      : super(_value, _then);

  @pragma('vm:prefer-inline')
  @override
  $Res call({
    Object? message = null,
  }) {
    return _then(_$AudioErrorStateImpl(
      null == message
          ? _value.message
          : message // ignore: cast_nullable_to_non_nullable
              as String,
    ));
  }
}

/// @nodoc

class _$AudioErrorStateImpl implements AudioErrorState {
  const _$AudioErrorStateImpl(this.message);

  @override
  final String message;

  @override
  String toString() {
    return 'AudioState.error(message: $message)';
  }

  @override
  bool operator ==(Object other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _$AudioErrorStateImpl &&
            (identical(other.message, message) || other.message == message));
  }

  @override
  int get hashCode => Object.hash(runtimeType, message);

  @JsonKey(ignore: true)
  @override
  @pragma('vm:prefer-inline')
  _$$AudioErrorStateImplCopyWith<_$AudioErrorStateImpl> get copyWith =>
      __$$AudioErrorStateImplCopyWithImpl<_$AudioErrorStateImpl>(
          this, _$identity);

  @override
  @optionalTypeArgs
  TResult when<TResult extends Object?>({
    required TResult Function() initial,
    required TResult Function() loading,
    required TResult Function(AudioModel audioModel) loaded,
    required TResult Function(String message) error,
  }) {
    return error(message);
  }

  @override
  @optionalTypeArgs
  TResult? whenOrNull<TResult extends Object?>({
    TResult? Function()? initial,
    TResult? Function()? loading,
    TResult? Function(AudioModel audioModel)? loaded,
    TResult? Function(String message)? error,
  }) {
    return error?.call(message);
  }

  @override
  @optionalTypeArgs
  TResult maybeWhen<TResult extends Object?>({
    TResult Function()? initial,
    TResult Function()? loading,
    TResult Function(AudioModel audioModel)? loaded,
    TResult Function(String message)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(message);
    }
    return orElse();
  }

  @override
  @optionalTypeArgs
  TResult map<TResult extends Object?>({
    required TResult Function(AudioInitialState value) initial,
    required TResult Function(AudioLoadingState value) loading,
    required TResult Function(AudioLoadedState value) loaded,
    required TResult Function(AudioErrorState value) error,
  }) {
    return error(this);
  }

  @override
  @optionalTypeArgs
  TResult? mapOrNull<TResult extends Object?>({
    TResult? Function(AudioInitialState value)? initial,
    TResult? Function(AudioLoadingState value)? loading,
    TResult? Function(AudioLoadedState value)? loaded,
    TResult? Function(AudioErrorState value)? error,
  }) {
    return error?.call(this);
  }

  @override
  @optionalTypeArgs
  TResult maybeMap<TResult extends Object?>({
    TResult Function(AudioInitialState value)? initial,
    TResult Function(AudioLoadingState value)? loading,
    TResult Function(AudioLoadedState value)? loaded,
    TResult Function(AudioErrorState value)? error,
    required TResult orElse(),
  }) {
    if (error != null) {
      return error(this);
    }
    return orElse();
  }
}

abstract class AudioErrorState implements AudioState {
  const factory AudioErrorState(final String message) = _$AudioErrorStateImpl;

  String get message;
  @JsonKey(ignore: true)
  _$$AudioErrorStateImplCopyWith<_$AudioErrorStateImpl> get copyWith =>
      throw _privateConstructorUsedError;
}
