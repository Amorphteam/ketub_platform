import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:ketub_platform/models/audio_model.dart';

part 'audio_state.freezed.dart';

@freezed
abstract class AudioState with _$AudioState {
  const factory AudioState.initial() = AudioInitialState;

  const factory AudioState.loading() = AudioLoadingState;

  const factory AudioState.loaded(AudioModel audioModel) = AudioLoadedState;

  const factory AudioState.error(String message) = AudioErrorState;
}
