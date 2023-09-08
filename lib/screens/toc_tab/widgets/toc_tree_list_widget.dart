import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/toc_tab/cubit/toc_cubit.dart';

class TocTreeListWidget extends StatelessWidget {
  final List<EpubChapter> tocList;

  const TocTreeListWidget({Key? key, required this.tocList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return _buildTreeList(tocList);
  }

  Widget _buildTreeList(List<EpubChapter> tocList) {
    return ListView.builder(
      itemCount: tocList.length,
      itemBuilder: (context, index) {
        EpubChapter groupItem = tocList[index];
        return _buildListTile(context, groupItem);
      },
    );
  }

  Widget _buildListTile(BuildContext context, EpubChapter groupItem) {
    if (groupItem.SubChapters != null) {
      return ExpansionTile(
        title: Text(groupItem.Title!),
        children: [
          _buildFirstChildList(groupItem.SubChapters!),
        ],
      );
    } else {
      return ListTile(
        title: Text(groupItem.Title!),
      );
    }
  }

  Widget _buildFirstChildList(List<EpubChapter> childItems) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems.length,
      itemBuilder: (context, index) {
        EpubChapter firstChildItem = childItems[index];
        return _buildFirstChildListTile(context, firstChildItem);
      },
    );
  }

  Widget _buildFirstChildListTile(
      BuildContext context, EpubChapter firstChildItem) {
    if (firstChildItem.SubChapters != null) {
      return ExpansionTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.Title!),
        ),
        children: [
          _buildSecondChildList(firstChildItem.SubChapters!),
        ],
      );
    } else {
      return ListTile(
        title: Padding(
          padding: const EdgeInsets.only(left: 16),
          child: Text(firstChildItem.Title!),
        ),
      );
    }
  }

  Widget _buildSecondChildList(List<EpubChapter> childItems2) {
    return ListView.builder(
      shrinkWrap: true,
      physics: ClampingScrollPhysics(),
      itemCount: childItems2.length,
      itemBuilder: (context, index) {
        EpubChapter secondChildItem = childItems2[index];
        return ListTile(
          title: Padding(
            padding: const EdgeInsets.only(left: 32),
            child: Text(secondChildItem.Title!),
          ),
          onTap: () {
            _openEpub(context, secondChildItem);
            },
        );
      },
    );
  }


  void _openEpub(BuildContext context, EpubChapter item){
    print('item is ${item.ContentFileName}');
    // BlocProvider.of<TocCubit>(context).openEpub(item);
  }
}
