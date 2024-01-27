import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ketub_platform/screens/audio/widgets/control_buttons_widget.dart';
import 'package:ketub_platform/utils/data_helper.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/common.dart';
import 'cubit/audio_player_cubit.dart';

class AudioScreen extends StatefulWidget {
  const AudioScreen({super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}

class _AudioScreenState extends State<AudioScreen> {
  final player = AudioPlayer();
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioPlayerCubit>(context).loadTrack(49715, player);
  }



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: <Widget>[
          Stack(
            children: <Widget>[
              Container(
                height: 160.0, // Height for the banner
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage('assets/images/banner.png'), // Replace with your image asset
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              AppBar(
                backgroundColor: Colors.transparent, // Makes the AppBar's background transparent
                elevation: 0, // Removes shadow
                title: Text('الأسس المنطقية للاستقراء'),
              ),
            ],
          ),
          Expanded(
            child: BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
              builder: (context, state) {
                return state.when(
                  initial: () => const Center(child: Text('Initial State')),
                  loading: () => const Center(child: CircularProgressIndicator()),
                  playing: () => _buildPlayingUI(context),
                  error: (message) => Center(child: Text('Error: $message')),
                );
              },
            ), // The rest of your page content
          ),
        ],
      ),
    );
  }

  Widget _buildPlayingUI(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        ControlButtonsWidget(player),
          // Container(
          //     height: 60.0,
          //     // child: SeekBar(
          //     //   duration: positionData?.duration ?? Duration.zero,
          //     //   position: positionData?.position ?? Duration.zero,
          //     //   bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          //     //   onChangeEnd: (newPosition) {
          //     //     player.seek(newPosition);
          //     //   },
          //     ),
          //   ),
        const SizedBox(height: 48.0),
        Text(
          "حلقات أخرى",
          style: Theme.of(context).textTheme.titleLarge,
        ),
        Expanded(
          child: ListView.builder(
                itemCount: DataHelper.playlist.length,
                itemBuilder: (context, index) {
                  final item = DataHelper.playlist[index];
                  return ListTile(
                    leading: Container(
                      width: 50,
                      height: 50,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        image: DecorationImage(
                          image: AssetImage('assets/images/bk2.jpg'),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    title: Text('Test'),
                    // Assuming MediaItem has a title field
                    // You might want to handle the subtitle, if it exists
                    onTap: () {
                      player.seek(Duration.zero, index: index);
                    },
                  );
                },
          ),
        ),
      ],
    );
  }

  _buildPausedUI(BuildContext context) {
    return Placeholder();
  }


}
