import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../cubit/toc_cubit.dart';

class EpubChapterListWidget extends StatefulWidget {
  final List<EpubChapter> tocTreeList;

  EpubChapterListWidget({required this.tocTreeList});

  @override
  _EpubChapterListWidgetState createState() => _EpubChapterListWidgetState();
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
      physics: ClampingScrollPhysics(),
      itemCount: widget.tocTreeList.length,
      itemBuilder: (context, index) {
        return buildChapterTree(widget.tocTreeList[index], index, 0);
      },
    );
  }

  Widget buildChapterTree(EpubChapter chapter, int parentIndex, int level) {
    final hasSubChapters = chapter.SubChapters != null && chapter.SubChapters!.isNotEmpty;

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.only(left: level * 16.0), // Adjust the left padding as needed
          child: ListTile(
            title: Text(chapter.Title ?? 'No Title'),
            trailing: hasSubChapters
                ? _isExpanded[parentIndex]
                ? Icon(Icons.arrow_drop_up)
                : Icon(Icons.arrow_drop_down)
                : null,
            // Add more content or actions for each chapter here
            onTap: () {
                BlocProvider.of<TocCubit>(context).openEpub(chapter);
              setState(() {
                _isExpanded[parentIndex] = !_isExpanded[parentIndex];
              });
            },
          ),
        ),
        if (hasSubChapters && _isExpanded[parentIndex])
          Column(
            children: chapter.SubChapters!.map((subChapter) {
              return buildChapterTree(subChapter, parentIndex, level + 1);
            }).toList(),
          ),
      ],
    );
  }
}
