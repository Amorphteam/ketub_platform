import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/epub/epub_screen.dart';
import 'package:ketub_platform/screens/internal_toc/widgets/internal_toc_tree_List.dart';



class InternalToc extends StatefulWidget {
  final List<EpubChapter> tocList;
  final DataCallback onDataTransfer;

  const InternalToc({Key? key, required this.tocList, required this.onDataTransfer}) : super(key: key);

  @override
  State<InternalToc> createState() => _InternalTocState();
}

class _InternalTocState extends State<InternalToc> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          // child: TextField(
          //   onChanged: (value) => _loadToc(context, value),
          //   decoration: InputDecoration(
          //     contentPadding: EdgeInsets.zero,
          //     labelText: 'Search',
          //     prefixIcon: Icon(Icons.search),
          //     border: OutlineInputBorder(
          //       borderRadius: BorderRadius.circular(10),
          //     ),
          //   ),
          // ),
        ),
        // Wrap your widget with a Material widget
        Material(
          child: Flexible(
            child: InternalTocTreeList(tocTreeList: widget.tocList, onDataTransfer: widget.onDataTransfer), // Replace with your actual widget
          ),
        ),
      ],
    );
  }

  _loadToc(BuildContext context, String? query) {

  }
}


