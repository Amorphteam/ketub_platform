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
        return _buildListTile(context, groupItem);
      },
    );
  }

  Widget _buildListTile(BuildContext context, TocGroupItem groupItem) {
    if (groupItem.childItems != null) {
      return ExpansionTile(
        title: Text(groupItem.bookTitle,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)
        ),
        subtitle: Text(groupItem.bookName,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)
        ),
        children: [
          _buildFirstChildList(groupItem.childItems),
        ],

      );
    } else {
      return ListTile(
        title: Text(groupItem.bookTitle,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
        subtitle: Text(groupItem.bookName,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.grey)),
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
        return _buildFirstChildListTile(context, firstChildItem);
      },
    );
  }

  Widget _buildFirstChildListTile(BuildContext context,TocFirstChildItem firstChildItem) {
    if (firstChildItem.childItems2 != null) {
      return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
        ),
        children: [
          _buildSecondChildList(firstChildItem.childItems2),
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
        ),
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
          title: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(secondChildItem.bookTitle, style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
          ),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return _buildTreeList(nodes);
  }
}