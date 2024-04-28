import 'package:flutter/material.dart';
import 'dart:math' as math;

import '../../../utils/common.dart';

class WaveformSeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final Function(Duration) onChangeEnd;

  WaveformSeekBar({
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    required this.onChangeEnd,
  });

  @override
  _WaveformSeekBarState createState() => _WaveformSeekBarState();
}

class _WaveformSeekBarState extends State<WaveformSeekBar> {
  late List<double> peakHeights;
  bool peaksAreGenerated = false;

  @override
  void initState() {
    super.initState();
  }

  void _generateWaveform() {
    final randomGenerator = math.Random();
    var screenWidth = MediaQuery.of(context).size.width;
    print('numbers of width ${screenWidth}');

    final numberOfPeaks = screenWidth / 8.5;
    final maxPeakHeight = 100.0;
    peakHeights = List.generate(
        numberOfPeaks.toInt(), (_) => randomGenerator.nextDouble() * maxPeakHeight);
    print('numbers of peakHeights ${peakHeights.length}');
    peaksAreGenerated = true;
  }

  void _seekToRelativePosition(Offset localPosition) {
    final RenderBox box = context.findRenderObject() as RenderBox;
    final double width = box.size.width;
    final double position = localPosition.dx;
    final double relativePosition = position.clamp(0, width) / width;
    final Duration newPosition = Duration(
        milliseconds:
        (widget.duration.inMilliseconds * relativePosition).round());
    widget.onChangeEnd(newPosition);
  }

  @override
  Widget build(BuildContext context) {
    if (!peaksAreGenerated) _generateWaveform();
    return Column(children: [
      Expanded(
        child: GestureDetector(
          onTapDown: (details) =>
              _seekToRelativePosition(details.localPosition),
          onPanUpdate: (details) =>
              _seekToRelativePosition(details.localPosition),
          onPanEnd: (details) {
            // You might want to call onChangeEnd again or perform some final action when the pan ends
          },
          child: CustomPaint(
            painter: StaticWaveformPainter(
              peakHeights: peakHeights,
              progress: widget.position.inMilliseconds /
                  widget.duration.inMilliseconds,
              bufferedProgress: widget.bufferedPosition.inMilliseconds /
                  widget.duration.inMilliseconds,
            ),
            size: Size.infinite,
          ),
        ),
      ),
      SizedBox(height: 20,),
      Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("${widget.position}")
                    ?.group(1) ??
                    '${widget.position}',
                style: Theme.of(context).textTheme.bodySmall),
          ),

          Padding(
            padding: const EdgeInsets.only(left: 16.0),
            child: Text(
                RegExp(r'((^0*[1-9]\d*:)?\d{2}:\d{2})\.\d+$')
                    .firstMatch("$_remaining")
                    ?.group(1) ??
                    '$_remaining',
                style: Theme.of(context).textTheme.bodySmall),
          ),
        ],
      ),
    ]);
  }

  Duration get _remaining => widget.duration - widget.position;
}


class StaticWaveformPainter extends CustomPainter {
  final List<double> peakHeights;
  final double progress;
  final double bufferedProgress;

  StaticWaveformPainter({
    required this.peakHeights,
    required this.progress,
    required this.bufferedProgress,
  });

  @override
  void paint(Canvas canvas, Size size) {
    var backgroundPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill; // Use fill style for the rectangles

    var bufferedPaint = Paint()
      ..color = Colors.black12
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    var progressPaint = Paint()
      ..color = Colors.green
      ..strokeWidth = 3.0
      ..style = PaintingStyle.fill;

    var gap = 8.0;
    var strokeWidth = 5.0;
    var middle = size.height / 2;
    var maxPeakHeight = 0.5;
    int numberOfPeaks = peakHeights.length;

    for (int i = 0; i < numberOfPeaks; i++) {
      var currentPeakHeight = peakHeights[i] * maxPeakHeight;
      var xOffset = size.width - (gap * i) - strokeWidth / 2; // Adjust for RTL
      var paint = (numberOfPeaks - i) / numberOfPeaks <= progress
          ? progressPaint
          : ((numberOfPeaks - i) / numberOfPeaks <= bufferedProgress
          ? bufferedPaint
          : backgroundPaint);

      // Create a path for a rounded rectangle
      var rect = RRect.fromLTRBR(
          xOffset - strokeWidth / 2, // left
          middle - currentPeakHeight / 2, // top
          xOffset + strokeWidth / 2, // right
          middle + currentPeakHeight / 2, // bottom
          Radius.circular(strokeWidth / 2)); // The radius of the corners

      canvas.drawRRect(rect, paint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
}
