import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import '../cubit/epub_cubit.dart';
import '../epub_screen.dart';
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
    

    return Material( // Keep the Material widget here
      child: Column(
        children: [
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Padding(
              padding: EdgeInsets.only(top: 32), // Add top padding to the TextField
              child: TextField(
                onChanged: (value) => _loadToc(value),
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.zero,
                  labelText: 'Search',
                  prefixIcon: Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                  ),
                ),
              ),
            ),
          ),
          Flexible(
            child: InternalTocTreeList(tocTreeList: _filteredToc, onDataTransfer: widget.onDataTransfer),
          ),
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



