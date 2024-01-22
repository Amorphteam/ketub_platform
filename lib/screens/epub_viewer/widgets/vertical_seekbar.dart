import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';

import '../cubit/epub_cubit.dart';

class VerticalSeekBar extends StatefulWidget {
  double currentPage;
  double allPagesCount;
  EpubViewerCubit epubViewerCubit;
  String bookPath;

  VerticalSeekBar(
      {required this.currentPage,
        required this.allPagesCount,
        required this.epubViewerCubit,
        required this.bookPath,
        Key? key})
      : super(key: key);

  @override
  _VerticalSeekBarState createState() => _VerticalSeekBarState();
}

class _VerticalSeekBarState extends State<VerticalSeekBar> {
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Slider(
        value: _currentValue,
        onChangeEnd: (newValue) {
          widget.epubViewerCubit.jumpToPage(newPage: newValue.toInt());
        },
        onChanged: (newValue) {
          setState(() {
            _currentValue = newValue;
          });
        },
        max: widget.allPagesCount,
        min: 0,
      ),
    );
  }
}
