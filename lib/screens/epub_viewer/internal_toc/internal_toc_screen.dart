import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import 'package:ketub_platform/screens/main/shared_widgets/search_bar_widget.dart';
import '../cubit/epub_cubit.dart';
import '../epub_viewer_screen.dart';
import 'widgets/internal_toc_tree_List_widget.dart';


class InternalToc extends StatefulWidget {
  final List<EpubChapter> tocList;
  final DataCallback onDataTransfer;
  final EpubViewerCubit epubViewerCubit;

  const InternalToc({Key? key, required this.tocList, required this.onDataTransfer, required this.epubViewerCubit}) : super(key: key);

  @override
  State<InternalToc> createState() => _InternalTocState();

}

class _InternalTocState extends State<InternalToc> {
  List<EpubChapter> _filteredToc = [];

  @override
  void initState() {
    super.initState();
    _loadToc('');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: SearchBarWiget(),
      ),
      body: Column(
        children: [
           InternalTocTreeList(tocTreeList: _filteredToc, onDataTransfer: widget.onDataTransfer),
        ],
      ),
    );
  }

  _loadToc(String? query) {
    // final filteredList = widget.epubCubit.filterToc(query: query);
    // setState(() {
    //   _filteredToc = filteredList;
    // });

  }
}



