import 'package:audio_service/audio_service.dart';
import 'package:audio_session/audio_session.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:just_audio/just_audio.dart';
import 'package:ketub_platform/screens/audio/widgets/control_buttons_widget.dart';
import 'package:ketub_platform/screens/audio/widgets/waveform_seek_bar.dart';
import 'package:ketub_platform/utils/data_helper.dart';
import 'package:rxdart/rxdart.dart';

import '../../utils/common.dart';
import 'cubit/audio_player_cubit.dart';

class AudioScreen extends StatefulWidget {
  int? id;

   AudioScreen({this.id, super.key});

  @override
  State<AudioScreen> createState() => _AudioScreenState();
}


class _AudioScreenState extends State<AudioScreen> {
  final player = AudioPlayerService().player;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AudioPlayerCubit>(context).loadTrack(widget.id ?? 49715, player);
  }



  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AudioPlayerCubit, AudioPlayerState>(
  builder: (context, state) {
    return Scaffold(
      body: CustomScrollView(
        slivers: <Widget>[
          SliverAppBar(
            expandedHeight: 200.0,
            floating: false,
            pinned: true,
            flexibleSpace: LayoutBuilder(
              builder: (BuildContext context, BoxConstraints constraints) {
                var top = constraints.biggest.height;
                double opacity =
                    (top - kToolbarHeight) / (200.0 - kToolbarHeight);
                opacity = opacity < 0.17
                    ? 0
                    : opacity > 1
                    ? 1
                    : opacity;
                double scale = 0 + (top - kToolbarHeight) / (200.0 - kToolbarHeight);
                scale = scale < 0.5 ? 0.7 : scale > 1 ? 1 : scale;
      
                return Stack(
                  fit: StackFit.expand,
                  children: [
                    FlexibleSpaceBar(
                      background: Image.asset(
                        'assets/images/banner.png',
                        // Replace with your image asset
                        fit: BoxFit.cover,
                      ),
                    ),
                    Positioned(
                      left: 16,
                      right: 36,
                      bottom: 16,
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              _getAppBarTitle(state),
                              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                                fontSize: Theme.of(context).textTheme.titleLarge!.fontSize! * scale,
                              ),
                              maxLines: opacity > 0 ? null : 1,
                              overflow: opacity > 0 ? TextOverflow.visible : TextOverflow.ellipsis,
                            ),
                            opacity > 0.4 ? Opacity(
                              opacity: opacity,
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.end,
                                children: [
                                  Text(
                                    _getAppBarDate(state),
                                    style: Theme.of(context).textTheme.labelLarge,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: _getAppBarDateIcon(state),
                                  ),
                                ],
                              ),
                            ) : SizedBox(),
                          ],
                        ),
                      ),
                    ),
                  ],
                );
              },
            ),
          ),
          SliverToBoxAdapter(
              child: Center(
                child: _buildBodyContent(state),
              ),
          ),
        ],
      ),
    );
  },
);
  }

  Widget _buildBodyContent(AudioPlayerState state) {
    return state.when(
      initial: () => const Text('Initial State'),
      loading: () => const Padding(
        padding: EdgeInsets.only(top: 20.0),
        child: Center(child: CircularProgressIndicator()),
      ),
      playing: (_, __, positionData) => _buildPlayingUI(context, positionData),
      error: (error) => Text(error ?? 'Error'),
    );
  }

  Widget _getAppBarDateIcon(AudioPlayerState state) {
    return state.maybeWhen(
      playing: (_, __, ___) => SvgPicture.asset('assets/icons/calendar.svg'),
      orElse: () => const Text(''),
    );
  }

  Widget _buildPlayingUI(BuildContext context, PositionData positionData) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 20,),
        ControlButtonsWidget(player),
          Container(
              height: 100.0,
              child: Center(
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: WaveformSeekBar(
                    duration: positionData.duration,
                    position: positionData.position,
                    bufferedPosition: positionData.bufferedPosition,
                    onChangeEnd: (newPosition) {
                      player.seek(newPosition);
                    },
                  ),
                ),
              ),
            ),
        const SizedBox(height: 48.0),
        // Text(
        //   "حلقات أخرى",
        //   style: Theme.of(context).textTheme.titleLarge,
        // ),
        // Expanded(
        //   child: ListView.builder(
        //         itemCount: DataHelper.playlist.length,
        //         itemBuilder: (context, index) {
        //           final item = DataHelper.playlist[index];
        //           return ListTile(
        //             leading: Container(
        //               width: 50,
        //               height: 50,
        //               decoration: BoxDecoration(
        //                 borderRadius: BorderRadius.circular(16),
        //                 image: DecorationImage(
        //                   image: AssetImage('assets/images/bk2.jpg'),
        //                   fit: BoxFit.cover,
        //                 ),
        //               ),
        //             ),
        //             title: Text('Test'),
        //             // Assuming MediaItem has a title field
        //             // You might want to handle the subtitle, if it exists
        //             onTap: () {
        //               player.seek(Duration.zero, index: index);
        //             },
        //           );
        //         },
        //   ),
        // ),
      ],
    );
  }


  String _getAppBarTitle(AudioPlayerState state) {
    return state.maybeWhen(
      playing: (title, _, __) => title,
      orElse: () => '',
    );
  }

  String _getAppBarDate(AudioPlayerState state) {
    return state.maybeWhen(
      playing: (_, date, __) => date.split('T')[0],
      orElse: () => '',
    );
  }

}


class AudioPlayerService {
  static final AudioPlayerService _instance = AudioPlayerService._internal();
  final AudioPlayer player = AudioPlayer();

  factory AudioPlayerService() {
    return _instance;
  }

  AudioPlayerService._internal();

}

