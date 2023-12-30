import 'package:audioplayers/audioplayers.dart';
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
  late AudioPlayer player;
  bool isPlaying = false; // Added a variable to track audio playing state

  @override
  void initState() {
    super.initState();
    player = AudioPlayer();
    _loadAudio();
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
          // You can handle audio loaded state here if needed
        }
      },
      builder: (context, state) {
        if (state is AudioLoadedState) {
          final mediaDownloadLink = state.audioModel.mediaDownloadLink;

          return Column(
            children: [
              ElevatedButton(
                onPressed: () {
                  // Toggle the audio playback when the button is pressed
                  if (isPlaying) {
                    player.pause();
                  } else {
                    player.play(UrlSource(mediaDownloadLink!));
                  }
                  setState(() {
                    isPlaying = !isPlaying; // Toggle the state
                  });
                },
                child: Text(isPlaying ? 'Pause Audio' : 'Play Audio'),
              ),
              Text('$mediaDownloadLink'),
            ],
          );
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


