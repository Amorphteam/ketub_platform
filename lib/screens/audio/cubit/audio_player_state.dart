part of 'audio_player_cubit.dart';

@freezed
class AudioPlayerState with _$AudioPlayerState {
  const factory AudioPlayerState.initial() = _Initial;
  const factory AudioPlayerState.loading() = _Loading;
  const factory AudioPlayerState.playing({required String title, required String date}) = _Playing;
  const factory AudioPlayerState.error(String message) = _Error;
}
