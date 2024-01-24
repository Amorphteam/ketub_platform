import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import '../../epub_viewer_screen.dart';




class InternalTocTreeList extends StatefulWidget {
  final List<EpubChapter> tocTreeList;
  final DataCallback onDataTransfer;
  const InternalTocTreeList({super.key, required this.tocTreeList, required this.onDataTransfer});

  @override
  State<InternalTocTreeList> createState() => _InternalTocTreeListState();
}

class _InternalTocTreeListState extends State<InternalTocTreeList> {
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
              if (chapter.SubChapters!.isEmpty) {
                  Navigator.pop(context);
                  widget.onDataTransfer(chapter);
              }else{
                setState(() {
                  _isExpanded[parentIndex] = !_isExpanded[parentIndex];
                });
              }
              
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
