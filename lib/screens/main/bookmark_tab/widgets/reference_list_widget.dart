import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

import '../cubit/bookmark_cubit.dart';

class ReferenceListWidget extends StatelessWidget {
  final List<ReferenceModel> referenceList;

  const ReferenceListWidget({Key? key, required this.referenceList})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2, // Two items per row
        childAspectRatio: (1.5),
        crossAxisSpacing: 8, // Spacing between columns
        mainAxisSpacing: 8, // Spacing between rows
      ),
      itemCount: referenceList.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: (){
            openEpub(context: context, reference: referenceList[index]);
          },
          child: Column(
            children: [
              SizedBox(
                height: 120,
                width: MediaQuery.of(context).size.width  / 2.2,
                child: Card(
                  elevation: 0.0,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Row(
                      children: [
                        GestureDetector(
                          onTap: () {
                            BlocProvider.of<BookmarkCubit>(context)
                                .deleteBookmark(referenceList[index].id!);
                          },
                          child: SvgPicture.asset(
                            'assets/icons/bookmarked.svg',
                          ),
                        ),
                        Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Text(
                              referenceList[index].title ?? 'Title',
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
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(referenceList[index].bookName ?? 'Book Name', overflow: TextOverflow.ellipsis, maxLines: 2,),
              // )
            ],
          ),
        );
      },
    );

  }


}
