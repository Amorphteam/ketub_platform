import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../models/audio_model.dart';
import '../../../repositories/audio_online_repository.dart';

part 'audio_state.dart';

class AudioCubit extends Cubit<AudioState> {
  AudioCubit() : super(AudioInitial());

  void loadAudio(int tag) async {
    try {
      final audioModel = await AudioOnlineRepository().getArticles(tag);
      print("tag$tag");
      emit(AudioLoadedState(audioModel));
      print("mediaDownloadLink${audioModel.mediaDownloadLink}");

    } catch (error) {
      if (error is Exception) {
        emit(AudioErrorState(error));
      }
    }
  }
}