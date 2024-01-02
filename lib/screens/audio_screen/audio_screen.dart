import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/audio_screen/widgets/stream_widget.dart';
import 'widgets/player_widget.dart';
import 'cubit/audio_cubit.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  late AudioPlayer player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _loadAudio();
    player.setReleaseMode(ReleaseMode.stop);

  }

  @override
  void dispose() {
    player.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AudioCubit, AudioState>(
      listener: (context, state) {
        if (state is AudioLoadedState) {
        }
      },
      builder: (context, state) {
        if (state is AudioLoadedState) {
          final mediaDownloadLink = state.audioModel.mediaDownloadLink;
          WidgetsBinding.instance.addPostFrameCallback((_) async {
            await player.play(UrlSource(mediaDownloadLink!));
            await player.resume();
          });
          return SingleChildScrollView(
            child: Column(
            children: [
              const Divider(),
              PlayerWidget(player: player),
              const Divider(),
              StreamWidget(player: player),
            ],

          ));
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

  void _loadAudio() {
    BlocProvider.of<AudioCubit>(context).loadAudio(49581);
  }
}


