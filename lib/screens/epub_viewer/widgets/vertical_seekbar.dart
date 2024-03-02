import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';

import '../cubit/epub_cubit.dart';

class EpubSeekbar extends StatefulWidget {
  double currentPage;
  double allPagesCount;
  EpubViewerCubit epubViewerCubit;

  EpubSeekbar(
      {required this.currentPage,
        required this.allPagesCount,
        required this.epubViewerCubit,
        Key? key})
      : super(key: key);

  @override
  _EpubSeekbarState createState() => _EpubSeekbarState();
}

class _EpubSeekbarState extends State<EpubSeekbar> {
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return Slider(
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
    );
  }
}
