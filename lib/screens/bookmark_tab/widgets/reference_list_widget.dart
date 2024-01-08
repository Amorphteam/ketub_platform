import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/bookmark_tab/cubit/bookmark_cubit.dart';
import 'package:ketub_platform/models/reference_model.dart';

class ReferenceListWidget extends StatelessWidget {
  final List<ReferenceModel> referenceList;

  const ReferenceListWidget({Key? key, required this.referenceList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: referenceList.length,
      itemBuilder: (context, index) {
        ReferenceModel item = referenceList[index];
        return ListTile(
          title: Text(item.title),
          subtitle: Text(item.bookName),
          trailing: IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () {
              BlocProvider.of<BookmarkCubit>(context).deleteBookmark(item.id!);
            },
          ),
          onTap: () {
            BlocProvider.of<BookmarkCubit>(context).openEpub(item);
            },
        );
      },
    );
  }


}
