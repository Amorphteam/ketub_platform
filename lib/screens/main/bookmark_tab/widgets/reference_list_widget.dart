import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/firestore_reference_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

import '../cubit/bookmark_cubit.dart';

class ReferenceListWidget extends StatelessWidget {
  final List<ReferenceModel>? referenceList;
  final List<FirestoreReferenceModel>? referenceFirestoreList;

  const ReferenceListWidget({Key? key, this.referenceList, this.referenceFirestoreList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Combine both lists to show them in the GridView
    final combinedList = [
      ...(referenceList ?? []),
      ...(referenceFirestoreList ?? [])
    ];

    return GridView.builder(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio: (1),
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
      ),
      itemCount: combinedList.length,
      itemBuilder: (context, index) {
        final item = combinedList[index];

        return GestureDetector(
          onTap: () {
            if (item is ReferenceModel) {
              openEpub(context: context, reference: item);
            } else if (item is FirestoreReferenceModel) {
              openEpub(context: context, firestoreReferenceModel: item);
            }
          },
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width / 2.2,
                child: Card(
                  elevation: 0.0,
                  color: Colors.grey[200],
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            if (item is ReferenceModel) {
                              BlocProvider.of<BookmarkCubit>(context)
                                  .deleteBookmark(item.id!);
                            } else if (item is FirestoreReferenceModel) {
                              BlocProvider.of<BookmarkCubit>(context)
                                  .deleteBookmarkFromFirestore(item.bookPath, item.navIndex);
                            }
                          },
                          child: SvgPicture.asset(
                            'assets/icons/bookmarked.svg',
                            color: Theme.of(context).colorScheme.onSurfaceVariant,
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              // Check the type before accessing the fields
                              item is ReferenceModel
                                  ? item.title ?? 'Title'
                                  : (item as FirestoreReferenceModel).title ?? 'Title',
                              style: Theme.of(context).textTheme.labelSmall,
                              textAlign: TextAlign.right,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  // Check the type before accessing the fields
                  item is ReferenceModel
                      ? item.bookName ?? 'Book Name'
                      : (item as FirestoreReferenceModel).bookName ?? 'Book Name',
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              )
            ],
          ),
        );
      },
    );
  }
}
