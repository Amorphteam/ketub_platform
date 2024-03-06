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
      physics: const ClampingScrollPhysics(),
      itemCount: widget.tocTreeList.length,
      itemBuilder: (context, index) {
        return buildTreeNode(widget.tocTreeList[index], 0, context);
      },
    );
  }


  Widget buildTreeNode(EpubChapter chapter, int level, BuildContext context) {
    const maxLevel = 5;
    const minFontSize = 10.0;
    const maxFontSize = 18.0;
    const minPadding = 0.0;
    const maxPadding = 40.0;
    final padding = level == 0 ? 8.0 : maxPadding - ((maxPadding - minPadding) / maxLevel) * level; // Calculate padding
    final fontSize = maxFontSize - ((maxFontSize - minFontSize) / maxLevel) * level; // Calculate font size

    // Check if the chapter has subitems
    bool hasSubItems = chapter.SubChapters != null && chapter.SubChapters!.isNotEmpty;

    return Padding(
      padding: EdgeInsets.only(right: padding), // Adjust the spacing here
      child: Theme(
        data: ThemeData(dividerColor: Colors.transparent), // Hide the divider
        child: ExpansionTile(
          title: GestureDetector(
            onLongPress: (){
              widget.epubViewerCubit.openEpub(chapter);
              widget.onClose();
            },
            child: Text(
              chapter.Title ?? '',
              style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSize.toDouble()), // Use the desired text style
            ),
          ),
          trailing: hasSubItems ? null : SizedBox.shrink(),
          children: hasSubItems ? chapter.SubChapters!.map((child) {
            return buildTreeNode(child, level + 1, context);
          }).toList() : [],
          onExpansionChanged: (bool expanded) {
            if (!hasSubItems) {
              widget.epubViewerCubit.openEpub(chapter);
              widget.onClose();
            }
          },
        ),
      ),
    );
  }
}

