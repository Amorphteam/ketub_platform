part of 'audio_cubit.dart';

 class AudioState {}

class AudioInitial extends AudioState {}

class AudioLoadedState extends AudioState {
  final AudioModel audioModel;
  AudioLoadedState(this.audioModel);
}

class AudioErrorState extends AudioState {
  final Exception error;
  AudioErrorState(this.error);
}