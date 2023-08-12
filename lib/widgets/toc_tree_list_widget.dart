import 'package:flutter/material.dart';
import 'package:ketub_platform/models/toc_model.dart';

class TocTreeListWidget extends StatelessWidget {
  final List<TocGroupItem> tocList;

  const TocTreeListWidget({Key? key, required this.tocList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTreeList(tocList);
  }

  Widget _buildTreeList(List<TocGroupItem> tocList) {
    return ListView.builder(
      itemCount: tocList.length,
      itemBuilder: (context, index) {
        TocGroupItem groupItem = tocList[index];
        return _buildListTile(context, groupItem);
      },
    );
  }

  Widget _buildListTile(BuildContext context, TocGroupItem groupItem) {
    if (groupItem.childItems != null) {
      return ExpansionTile(
        title: Text(groupItem.bookTitle,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black)),
        subtitle: Text(groupItem.bookName,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(color: Colors.grey)),
        children: [
          _buildFirstChildList(groupItem.childItems!),
        ],
      );
    } else {
      return ListTile(
        title: Text(groupItem.bookTitle,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.black)),
        subtitle: Text(groupItem.bookName,
            style: Theme.of(context)
                .textTheme
                .titleSmall
                ?.copyWith(color: Colors.grey)),
      );
    }
  }

  Widget _buildFirstChildList(List<TocGroupItem> childItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems.length,
      itemBuilder: (context, index) {
        TocGroupItem firstChildItem = childItems[index];
        return _buildFirstChildListTile(context, firstChildItem);
      },
    );
  }

  Widget _buildFirstChildListTile(
      BuildContext context, TocGroupItem firstChildItem) {
    if (firstChildItem.childItems != null) {
      return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black)),
        ),
        children: [
          _buildSecondChildList(firstChildItem.childItems!),
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black)),
        ),
      );
    }
  }

  Widget _buildSecondChildList(List<TocGroupItem> childItems2) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems2.length,
      itemBuilder: (context, index) {
        TocGroupItem secondChildItem = childItems2[index];
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(secondChildItem.bookTitle,
                style: Theme.of(context)
                    .textTheme
                    .titleSmall
                    ?.copyWith(color: Colors.black)),
          ),
        );
      },
    );
  }
}
