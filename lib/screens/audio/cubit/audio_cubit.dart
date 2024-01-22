
import 'dart:math';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ketub_platform/repositories/audio_online_repository.dart';
import 'package:ketub_platform/utils/audio_manager.dart';

import 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  static final AudioCubit _singleton = AudioCubit._internal();

  factory AudioCubit() => _singleton;

  AudioCubit._internal() : super(const AudioState.initial());

  bool _isLoaded = false;
  void loadAudio(int tag) async {
    if (_isLoaded) return;
    _isLoaded = true;

    try {
      emit(const AudioState.loading());
      final audioModel = await AudioOnlineRepository().getArticles(tag);
      print("Parsed AudioModel: $audioModel");
      if (audioModel.mediaDownloadLink == null || audioModel.coverImage == null || audioModel.category?.name == null) {
        emit(AudioState.error(e.toString()));
        return;
      }
      AudioSource source = AudioSource.uri(
        Uri.parse(audioModel.mediaDownloadLink!),
        tag: MediaItem(
          id: audioModel.id.toString(),
          album: audioModel.category!.name!,
          title: audioModel.name!,
          artUri: Uri.parse(audioModel.coverImage!),
        ),
      );

      AudioManager.updatePlaylist([source]);
      emit(AudioState.loaded(audioModel));
    } catch (e) {
      emit(AudioState.error(e.toString()));
    }
  }

  void resetLoadedState() {
    _isLoaded = false;
  }
}
