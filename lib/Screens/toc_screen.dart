import 'package:flutter/material.dart';
import 'package:ketub_platform/models/toc_model.dart';
import 'package:ketub_platform/widgets/toc_tree_list_widget.dart';

class TocScreen extends StatefulWidget {
  final List<TocGroupItem> tocList;

  const TocScreen(this.tocList);

  @override
  _TocScreenState createState() => _TocScreenState();
}

class _TocScreenState extends State<TocScreen> {
  List<TocGroupItem> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.tocList;
  }

  void filterList(String query) {
    setState(() {
      filteredList = widget.tocList.where((item) {
        return item.bookTitle.toLowerCase().contains(query.toLowerCase());
      }).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
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
          child: TocTreeListWidget(tocList: filteredList),
        ),
      ],
    );
  }
}
