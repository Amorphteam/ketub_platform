import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/toc_tab/cubit/toc_cubit.dart';

class TocTreeListWidget extends StatelessWidget {
  final List<TreeTocModel> tocList;

  const TocTreeListWidget({Key? key, required this.tocList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTreeList(tocList);
  }

  Widget _buildTreeList(List<TreeTocModel> tocList) {
    return ListView.builder(
      itemCount: tocList.length,
      itemBuilder: (context, index) {
        TreeTocModel groupItem = tocList[index];
        return _buildListTile(context, groupItem);
      },
    );
  }

  Widget _buildListTile(BuildContext context, TreeTocModel groupItem) {
    if (groupItem.childItems != null) {
      return ExpansionTile(
        title: Text(groupItem.bookTitle),
        subtitle: Text(groupItem.bookName),
        children: [
          _buildFirstChildList(groupItem.childItems!),
        ],
      );
    } else {
      return ListTile(
        title: Text(groupItem.bookTitle),
        subtitle: Text(groupItem.bookName),
      );
    }
  }

  Widget _buildFirstChildList(List<TreeTocModel> childItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems.length,
      itemBuilder: (context, index) {
        TreeTocModel firstChildItem = childItems[index];
        return _buildFirstChildListTile(context, firstChildItem);
      },
    );
  }

  Widget _buildFirstChildListTile(
      BuildContext context, TreeTocModel firstChildItem) {
    if (firstChildItem.childItems != null) {
      return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle),
        ),
        children: [
          _buildSecondChildList(firstChildItem.childItems!),
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.bookTitle),
        ),
      );
    }
  }

  Widget _buildSecondChildList(List<TreeTocModel> childItems2) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems2.length,
      itemBuilder: (context, index) {
        TreeTocModel secondChildItem = childItems2[index];
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(secondChildItem.bookTitle),
          ),
          onTap: () {
            _openEpub(context, secondChildItem);
            },
        );
      },
    );
  }


  void _openEpub(BuildContext context, TreeTocModel item){
    BlocProvider.of<TocCubit>(context).openEpub(item);
  }
}
