import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:just_audio/just_audio.dart';

import '../../../utils/common.dart';

class ControlButtonsWidget extends StatefulWidget {
  final AudioPlayer player;
  Function onPlayClicked;

  ControlButtonsWidget(this.player, {required this.onPlayClicked, Key? key}) : super(key: key);

  @override
  State<ControlButtonsWidget> createState() => _ControlButtonsWidgetState();
}

class _ControlButtonsWidgetState extends State<ControlButtonsWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        IconButton(
          icon: const Icon(Icons.volume_up),
          onPressed: () {
            showSliderDialog(
              context: context,
              title: "درجة الصوت",
              divisions: 10,
              min: 0.0,
              max: 1.0,
              stream: widget.player.volumeStream,
              onChanged: widget.player.setVolume,
            );
          },
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/forword.svg'),
          onPressed: () async {
            // Get the current position
            final currentPosition = await widget.player.position;
            // Calculate the new position by adding 5 seconds
            final newPosition = currentPosition - Duration(seconds: 5);
            // Seek to the new position
            widget.player.seek(newPosition);
          },
        ),

        StreamBuilder<PlayerState>(
          stream: widget.player.playerStateStream,
          builder: (context, snapshot) {
            final playerState = snapshot.data;
            final processingState = playerState?.processingState;
            final playing = playerState?.playing;
            if (processingState == ProcessingState.loading ||
                processingState == ProcessingState.buffering) {
              return Container(
                margin: const EdgeInsets.all(8.0),
                width: 64.0,
                height: 64.0,
                child: const CircularProgressIndicator(),
              );
            } else if (playing != true) {
              return IconButton(
                icon: SvgPicture.asset('assets/icons/play.svg'),
                iconSize: 64.0,
                onPressed: (){
                  widget.onPlayClicked();
                  widget.player.play();
                }
              );
            } else if (processingState != ProcessingState.completed) {
              return IconButton(
                icon: SvgPicture.asset('assets/icons/pause.svg'),
                iconSize: 64.0,
                onPressed: widget.player.pause,
              );
            } else {
              return IconButton(
                icon: const Icon(Icons.replay),
                iconSize: 64.0,
                onPressed: () => widget.player.seek(Duration.zero,
                    index: widget.player.effectiveIndices!.first),
              );
            }
          },
        ),
        IconButton(
          icon: SvgPicture.asset('assets/icons/reply.svg'),
          onPressed: () async {
            // Get the current position
            final currentPosition = await widget.player.position;
            // Calculate the new position by adding 5 seconds
            final newPosition = currentPosition + Duration(seconds: 10);
            // Seek to the new position
            widget.player.seek(newPosition);
          },
        ),
        StreamBuilder<double>(
          stream: widget.player.speedStream,
          builder: (context, snapshot) => IconButton(
            icon: Text("${snapshot.data?.toStringAsFixed(1)}x",
                style: const TextStyle(fontWeight: FontWeight.bold)),
            onPressed: () {
              showSliderDialog(
                context: context,
                title: "سرعة القراءة",
                divisions: 10,
                min: 0.5,
                max: 1.5,
                stream: widget.player.speedStream,
                onChanged: widget.player.setSpeed,
              );
            },
          ),
        ),
      ],
    );
  }
}
