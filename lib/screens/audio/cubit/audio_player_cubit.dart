import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ketub_platform/models/article_model.dart';
import 'package:rxdart/rxdart.dart';
import '../../../repositories/articles_online_repository.dart';
import '../../../utils/common.dart';

part 'audio_player_state.dart';

part 'audio_player_cubit.freezed.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(const AudioPlayerState.initial());

  Future<void> loadTrack(int? id, AudioPlayer player) async {
    try {
      emit(const AudioPlayerState.loading());
      await player.stop();
      final track = await ArticleOnlineRepository().getArticles(id ?? 49715);
      _setTrack(track, player);
      _trackPosition(player, track);
    } catch (e) {
      emit(AudioPlayerState.error(e.toString()));
    }
  }

  void _trackPosition(AudioPlayer player, ArticleModel track) {
    Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
      player.positionStream,
      player.bufferedPositionStream,
      player.durationStream,
          (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
    ).listen((positionData) {
      emit(AudioPlayerState.playing(
          title: track.name ?? '',
          date: track.createdAt ?? '',
          positionData: positionData));
    });

  }

  _setTrack(ArticleModel track, AudioPlayer player) {
    final _audioSource = AudioSource.uri(
      Uri.parse(track.mediaDownloadLink ?? ''),
      tag: MediaItem(
        id: track.id.toString(),
        album: 'حيدر حب الله',
        title: track.name ?? '',
        artist: 'حيدر حب الله',
      ),
    );

    player.setAudioSource(_audioSource);

  }
}
