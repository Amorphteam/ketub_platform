import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/bookmark_tab/cubit/bookmark_cubit.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/screens/epub/epub_screen.dart';

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
          title: Text(item.title,
              style: Theme.of(context)
                  .textTheme
                  .titleSmall
                  ?.copyWith(color: Colors.black)),
          subtitle: Text(item.bookName,
              style: Theme.of(context)
                  .textTheme
                  .bodySmall
                  ?.copyWith(color: Colors.grey)),
          trailing: IconButton(
            icon: Icon(Icons.delete),
            onPressed: () {
              _delete(context,
                  item.id); // Call the _delete method with the item's id
            },
          ),
          onTap: () {
            _update(context, item);
            _navigateToDetailScreen(context, item);
          },
        );
      },
    );
  }

  void _update(BuildContext context, ReferenceModel bookmark) {
    BlocProvider.of<BookmarkCubit>(context).updateBookmark(bookmark);
  }

  void _delete(BuildContext context, int id) {
    BlocProvider.of<BookmarkCubit>(context).deleteBookmark(id);
  }

  void _navigateToDetailScreen(BuildContext context, ReferenceModel item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => EpubScreen(referenceModel: item),
      ),
    );
  }
}
