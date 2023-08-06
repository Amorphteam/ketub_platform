import 'package:flutter/material.dart';
import 'package:ketub_platform/models/toc_model.dart';

class TocPage extends StatelessWidget {
  final List<TocGroupItem> nodes;

  TocPage(this.nodes);

  Widget _buildTreeList(List<TocGroupItem> nodes) {
    return ListView.builder(
      itemCount: nodes.length,
      itemBuilder: (context, index) {
        TocGroupItem groupItem = nodes[index];
        return _buildListTile(groupItem);
      },
    );
  }

  Widget _buildListTile(TocGroupItem groupItem) {
    if (groupItem.childItems != null) {
      return ExpansionTile(
        title: Text(groupItem.bookTitle),
        subtitle: Text(groupItem.bookName),
        children: [
          _buildFirstChildList(groupItem.childItems),
        ],
      );
    } else {
      return ListTile(
        title: Text(groupItem.bookTitle),
        subtitle: Text(groupItem.bookName),
      );
    }
  }

  Widget _buildFirstChildList(List<TocFirstChildItem> childItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems.length,
      itemBuilder: (context, index) {
        TocFirstChildItem firstChildItem = childItems[index];
        return _buildFirstChildListTile(firstChildItem);
      },
    );
  }

  Widget _buildFirstChildListTile(TocFirstChildItem firstChildItem) {
    if (firstChildItem.childItems2 != null) {
      return ExpansionTile(
        title: Text(firstChildItem.bookTitle),
        subtitle: Text(firstChildItem.bookName),
        children: [
          _buildSecondChildList(firstChildItem.childItems2),
        ],
      );
    } else {
      return ListTile(
        title: Text(firstChildItem.bookTitle),
        subtitle: Text(firstChildItem.bookName),
      );
    }
  }

  Widget _buildSecondChildList(List<TocSecondChildItem> childItems2) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems2.length,
      itemBuilder: (context, index) {
        TocSecondChildItem secondChildItem = childItems2[index];
        return ListTile(
          title: Text(secondChildItem.bookTitle),
          subtitle: Text(secondChildItem.bookName),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTreeList(nodes);
  }
}