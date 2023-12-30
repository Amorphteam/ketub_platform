import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'cubit/audio_cubit.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  @override
  void initState() {
    super.initState();
    _loadAudio();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioCubit, AudioState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is AudioLoadedState) {
          final mediaDownloadLink = state.audioModel.mediaDownloadLink;
          return Text('$mediaDownloadLink');

        } else if (state is AudioErrorState) {
          return const Text('Error loading audio data');
        } else {
          return const CircularProgressIndicator();
        }
      },
      buildWhen: (previousState, state) {
        return state is AudioLoadedState;
      },
    );
  }

  @override
  void _loadAudio() {
    BlocProvider.of<AudioCubit>(context).loadAudio(49581);
  }
}
