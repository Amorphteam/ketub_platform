import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ketub_platform/screens/audio/cubit/audio_state.dart';
import 'package:ketub_platform/screens/audio/widgets/audio_player_screen.dart';
import 'package:ketub_platform/utils/audio_manager.dart';
import 'package:ketub_platform/utils/common.dart';
import 'cubit/audio_cubit.dart';

class AudioScreen extends StatelessWidget {
  const AudioScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => AudioCubit()..loadAudio(49581),
      child: AudioView(),
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
        state.maybeWhen(
            error: (message) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Error: $message')),
              );
            },
            orElse: () {});
      },
      child: Scaffold(
        body: SafeArea(
          child: BlocBuilder<AudioCubit, AudioState>(
            builder: (context, state) {
              return state.when(
                  initial: () => const Center(child: Text('Initial State')),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  loaded: (audioModel) => _buildAudioPlayerUI(),
                  error: (message) => Center(child: Text('Error: $message'))
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _buildAudioPlayerUI() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        // Stack for Image, Centered Text, and Bottom Left Title
        StreamBuilder<SequenceState?>(
          stream: AudioManager.player.sequenceStateStream,
          builder: (context, snapshot) {
            final state = snapshot.data;
            if (state?.sequence.isEmpty ?? true) {
              return const SizedBox();
            }
            final metadata = state!.currentSource!.tag as MediaItem;
            return Stack(
              alignment: Alignment.center,
              children: [
                // Image at the top
                Image.network(
                  metadata.artUri.toString(),
                  fit: BoxFit.cover,
                  width: double.infinity,
                  height: 300, // Adjust height as needed
                  errorBuilder: (BuildContext context, Object exception, StackTrace? stackTrace) {
                    return Image.asset('assets/images/banner.png');
                  },
                ),
                // Centered Text
                Center(
                  child: Text(
                    metadata.title,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                    ),
                  ),
                ),
                // Bottom Left Title
                Positioned(
                  left: 8.0,
                  bottom: 8.0,
                  child: Text(
                    metadata.album!,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 20,
                    ),
                  ),
                ),
              ],
            );
          },
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
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
                    style: Theme
                        .of(context)
                        .textTheme
                        .titleLarge,
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
                          child: Container(
                            color: i == state!.currentIndex ? Colors.grey.shade300 : null,
                            padding: EdgeInsets.all(8.0), // Add padding
                            child: Row(
                              children: [
                                Expanded(
                                  child: ListTile(
                                    title: Text(sequence[i].tag.title as String,
                                    textAlign: TextAlign.end),
                                    subtitle: Text(sequence[i].tag.title as String,
                                    textAlign: TextAlign.end),
                                    onTap: () {
                                      AudioManager.player.seek(Duration.zero, index: i);
                                    },
                                  ),
                                ),

                                Image.asset(
                                  'assets/images/audio_bk.jpg',
                                  width: 64.0, // Adjust the width as needed
                                  height: 64.0, // Adjust the height as needed
                                ),
                              ],
                            ),
                          ),
                        ),
                    ],
                  );
                },
              ),
            )

          ],
        ),

      ],
    );
  }
}
