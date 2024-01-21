import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:just_audio/just_audio.dart';
import 'package:rxdart/rxdart.dart';
import 'common.dart';


class AudioManager {
  static final AudioPlayer player = AudioPlayer();
  static final ConcatenatingAudioSource _playlist = ConcatenatingAudioSource(children: []);

  static Future<void> init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(statusBarColor: Colors.black));

    try {
      await player.setAudioSource(_playlist);
    } catch (e) {
      print("Error initializing playlist: $e");
    }
  }
  static Stream<PositionData> get positionDataStream =>
      Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
          player.positionStream,
          player.bufferedPositionStream,
          player.durationStream,
              (position, bufferedPosition, duration) => PositionData(
              position,
              bufferedPosition,
              duration ?? Duration.zero
          )
      );

  static void updatePlaylist(List<AudioSource> newSources) async {
    _playlist.clear();
    _playlist.addAll(newSources);
    await player.setAudioSource(_playlist);
  }

  static void movePlaylistItem(int oldIndex, int newIndex) {
    _playlist.move(oldIndex, newIndex);
    player.setAudioSource(_playlist);
  }

  static void removePlaylistItemAt(int index) {
    _playlist.removeAt(index);
    player.setAudioSource(_playlist);
  }

}