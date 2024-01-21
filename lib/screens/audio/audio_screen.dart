import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ketub_platform/screens/audio/widgets/audio_player_screen.dart';
import 'package:ketub_platform/utils/audio_manager.dart';
import 'package:ketub_platform/utils/common.dart';
import 'cubit/audio_cubit.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: BlocProvider(
        create: (context) => AudioCubit()..loadAudio(49581),
        child: AudioView(),
      ),
    );
  }
}

class AudioView extends StatefulWidget {
  @override
  _AudioViewState createState() => _AudioViewState();
}

class _AudioViewState extends State<AudioView> {



  @override
  Widget build(BuildContext context) {
    return BlocListener<AudioCubit, AudioState>(
      listener: (context, state) {
        if (state is AudioErrorState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text('Error: ${state.message}')),
          );
        }
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              if (state is AudioLoadingState) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is AudioLoadedState) {
                return _buildAudioPlayerUI();
              }
              return const Center(child: Text('Something went wrong!'));
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayerUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Expanded(
          child: StreamBuilder<SequenceState?>(
            stream: AudioManager.player.sequenceStateStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              if (state?.sequence.isEmpty ?? true) {
                return const SizedBox();
              }
              final metadata = state!.currentSource!.tag as MediaItem;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Center(
                          child: Image.network(metadata.artUri.toString(),
                            errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace){
                              return Image.asset('assets/images/book_sample.png');
                            },
                          )

                      ),
                    ),
                  ),
                  Text(metadata.album!, style: Theme.of(context).textTheme.titleLarge),
                  Text(metadata.title),
                ],
              );
            },
          ),
        ),
        AudioPlayerScreen(AudioManager.player),
        StreamBuilder<PositionData>(
          stream: AudioManager.positionDataStream,
          builder: (context, snapshot) {
            final positionData = snapshot.data;
            return SeekBar(
              duration: positionData?.duration ?? Duration.zero,
              position: positionData?.position ?? Duration.zero,
              bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
              onChangeEnd: (newPosition) {
                AudioManager.player.seek(newPosition);
              },
            );
          },
        ),
        const SizedBox(height: 8.0),
        Row(
          children: [
            StreamBuilder<LoopMode>(
              stream: AudioManager.player.loopModeStream,
              builder: (context, snapshot) {
                final loopMode = snapshot.data ?? LoopMode.off;
                const icons = [
                  Icon(Icons.repeat, color: Colors.grey),
                  Icon(Icons.repeat, color: Colors.orange),
                  Icon(Icons.repeat_one, color: Colors.orange),
                ];
                const cycleModes = [
                  LoopMode.off,
                  LoopMode.all,
                  LoopMode.one,
                ];
                final index = cycleModes.indexOf(loopMode);
                return IconButton(
                  icon: icons[index],
                  onPressed: () {
                    AudioManager.player.setLoopMode(cycleModes[
                        (cycleModes.indexOf(loopMode) + 1) %
                            cycleModes.length]);
                  },
                );
              },
            ),
            Expanded(
              child: Text(
                "Playlist",
                style: Theme.of(context).textTheme.titleLarge,
                textAlign: TextAlign.center,
              ),
            ),
            StreamBuilder<bool>(
              stream: AudioManager.player.shuffleModeEnabledStream,
              builder: (context, snapshot) {
                final shuffleModeEnabled = snapshot.data ?? false;
                return IconButton(
                  icon: shuffleModeEnabled
                      ? const Icon(Icons.shuffle, color: Colors.orange)
                      : const Icon(Icons.shuffle, color: Colors.grey),
                  onPressed: () async {
                    final enable = !shuffleModeEnabled;
                    if (enable) {
                      await AudioManager.player.shuffle();
                    }
                    await AudioManager.player.setShuffleModeEnabled(enable);
                  },
                );
              },
            ),
          ],
        ),
        SizedBox(
          height: 240.0,
          child: StreamBuilder<SequenceState?>(
            stream: AudioManager.player.sequenceStateStream,
            builder: (context, snapshot) {
              final state = snapshot.data;
              final sequence = state?.sequence ?? [];
              return ReorderableListView(
                onReorder: (int oldIndex, int newIndex) {
                  if (oldIndex < newIndex) newIndex--;
                  AudioManager.movePlaylistItem(oldIndex, newIndex);
                },
                children: [
                  for (var i = 0; i < sequence.length; i++)
                    Dismissible(
                      key: ValueKey(sequence[i]),
                      background: Container(
                        color: Colors.redAccent,
                        alignment: Alignment.centerRight,
                        child: const Padding(
                          padding: EdgeInsets.only(right: 8.0),
                          child: Icon(Icons.delete, color: Colors.white),
                        ),
                      ),
                      onDismissed: (dismissDirection) {
                        AudioManager.removePlaylistItemAt(i);
                      },
                      child: Material(
                        color: i == state!.currentIndex
                            ? Colors.grey.shade300
                            : null,
                        child: ListTile(
                          title: Text(sequence[i].tag.title as String),
                          onTap: () {
                            AudioManager.player.seek(Duration.zero, index: i);
                          },
                        ),
                      ),
                    ),
                ],
              );
            },
          ),
        ),
      ],
    );
  }
}
