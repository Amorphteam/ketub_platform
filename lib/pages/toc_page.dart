import 'package:flutter/material.dart';
import 'package:ketub_platform/models/toc_model.dart';
import 'package:ketub_platform/widget/toc_list_widget.dart';
import 'package:ketub_platform/widget/toc_tree_list_widget.dart';

class TocPage extends StatefulWidget {
  final List<TocGroupItem> tocList;
  const TocPage(this.tocList);

  @override
  _TocPageState createState() => _TocPageState();
}
class _TocPageState extends State<TocPage> {
  List<TocGroupItem> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.tocList;
  }


  void filterList(String query) {
    setState(() {
      filteredList = widget.tocList.where((item) {
        return item.bookTitle.toLowerCase().contains(query.toLowerCase()) ||
            item.childItems.any((childItem) {
              return childItem.bookTitle.toLowerCase().contains(query.toLowerCase()) ||
                  childItem.childItems2.any((secondChildItem) {
                    return secondChildItem.bookTitle.toLowerCase().contains(query.toLowerCase());
                  });
            });
      }).toList();

    });
  }
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16,vertical: 10),
          child: TextField(
            onChanged: (value) => filterList(value),
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
        Expanded(
          child: filteredList.isNotEmpty
              ? TocTreeListWidget(tocList: widget.tocList)
              : TocListWidget(tocList: widget.tocList),
        ),
      ],
    );
  }
}
