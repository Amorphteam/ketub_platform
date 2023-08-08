import 'package:flutter/material.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/widgets/reference_list_widget.dart';

class BookmarkScreen extends StatefulWidget {
  final List<ReferenceModel> referenceList;
  const BookmarkScreen(this.referenceList);
  
  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {

  List<ReferenceModel> filteredList = [];

  @override
  void initState() {
    super.initState();
    filteredList = widget.referenceList;
  }


  void filterList(String query) {
    setState(() {
      filteredList = widget.referenceList.where((item) {
        return item.title.toLowerCase().contains(query.toLowerCase());
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
          child: ReferenceListWidget(referenceList: filteredList),
        ),

      ],
    );
  }
}
