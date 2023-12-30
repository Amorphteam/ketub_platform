import 'package:bloc/bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import '../../../models/audio_model.dart';
import '../../../repositories/audio_online_repository.dart';
import '../../../utils/audio_manager.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  static final AudioCubit _singleton = AudioCubit._internal();

  factory AudioCubit() => _singleton;

  AudioCubit._internal() : super(AudioInitialState());

  bool _isLoaded = false;

  void loadAudio(int tag) async {
    if (_isLoaded) return;
    _isLoaded = true;
    try {
      emit(AudioLoadingState());
      final audioModel = await AudioOnlineRepository().getArticles(tag);
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
      emit(AudioLoadedState(audioModel: audioModel));
    } catch (e) {
      emit(AudioErrorState(message: e.toString()));
    }
  }

  void resetLoadedState() {
    _isLoaded = false;
  }
}
