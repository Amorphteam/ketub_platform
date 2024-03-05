import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../epub_viewer/cubit/epub_viewer_cubit.dart';
import '../cubit/toc_cubit.dart';

class EpubChapterListWidget extends StatefulWidget {
  final List<EpubChapter> tocTreeList;
  final ScrollController scrollController; // Add a ScrollController parameter
  final EpubViewerCubit epubViewerCubit;
  final Function onClose;

  EpubChapterListWidget({required this.tocTreeList, required this.scrollController, required this.epubViewerCubit, required this.onClose});

  @override
  State<EpubChapterListWidget> createState() => _EpubChapterListWidgetState();
}

class _EpubChapterListWidgetState extends State<EpubChapterListWidget> {
  List<bool> _isExpanded = [];

  @override
  void initState() {
    super.initState();
    _isExpanded = List<bool>.generate(widget.tocTreeList.length, (index) => false);
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      shrinkWrap: true,
      controller: widget.scrollController, // Use the provided scrollController
      physics: ClampingScrollPhysics(),
      itemCount: widget.tocTreeList.length,
      itemBuilder: (context, index) {
        return buildChapterTree(context, widget.tocTreeList[index], index, 0);
      },
    );
  }

  Widget buildChapterTree(BuildContext context, EpubChapter chapter, int parentIndex, int level) {
    final hasSubChapters = chapter.SubChapters != null && chapter.SubChapters!.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: level * 16.0), // Adjust the left padding as needed
          child: ListTile(
            title: Text(chapter.Title ?? 'No Title'),
            trailing: hasSubChapters
                ? Icon(_isExpanded[parentIndex] ? Icons.arrow_drop_up : Icons.arrow_drop_down)
                : null,
            // Add more content or actions for each chapter here
            onTap: () {
              widget.epubViewerCubit.openEpub(chapter);
              widget.onClose();
              _toggleExpansion(parentIndex);
            },
          ),
        ),
        if (hasSubChapters && _isExpanded[parentIndex])
          Column(
            children: chapter.SubChapters!.map((subChapter) {
              return buildChapterTree(context, subChapter, parentIndex, level + 1);
            }).toList(),
          ),
      ],
    );
  }

  void _toggleExpansion(int index) {
    _isExpanded[index] = !_isExpanded[index];
  }
}
