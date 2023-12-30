part of 'audio_cubit.dart';


abstract class AudioState {}

class AudioInitialState extends AudioState {}

class AudioLoadingState extends AudioState {}

class AudioLoadedState extends AudioState {
  final AudioModel audioModel;
  AudioLoadedState({required this.audioModel});
}

class AudioErrorState extends AudioState {
  final String message;
  AudioErrorState({required this.message});
}


