import 'package:audio_service/audio_service.dart';
import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ketub_platform/models/article_model.dart';
import '../../../repositories/articles_online_repository.dart';
import '../../../utils/common.dart';

part 'audio_player_state.dart';

part 'audio_player_cubit.freezed.dart';

class AudioPlayerCubit extends Cubit<AudioPlayerState> {
  AudioPlayerCubit() : super(const AudioPlayerState.initial());

  Future<void> loadTrack(int? id, AudioPlayer player) async {
    try {
      emit(const AudioPlayerState.loading());
      final track = await ArticleOnlineRepository().getArticles(id ?? 49715);
      _setTrack(track, player);
      emit(AudioPlayerState.playing(title: track.name ?? '', date: track.createdAt ?? ''));
    } catch (e) {
      emit(AudioPlayerState.error(e.toString()));
    }
  }

  _setTrack(ArticleModel track, AudioPlayer player) {
    final _audioSource = AudioSource.uri(
      Uri.parse('https://dl.hobbollah.com/hob_uploads/mohazerat/albahs_alkharej/feqh/feqh_aljehad/096.MP3'),
      tag: MediaItem(
        id: '1',
        album: "موقع حيدر حب الله",
        title: 'الأسس المنطقية للاستقراء',
        artist: "موقع حيدر حب الله",
      ),
    );

    player.setAudioSource(_audioSource);

  }
}
