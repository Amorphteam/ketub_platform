import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/reference_model.dart';
import '../../../../utils/epub_helper.dart';
import '../cubit/bookmark_cubit.dart';

class ReferenceListWidget extends StatelessWidget {
  final List<ReferenceModel> referenceList;

  const ReferenceListWidget({Key? key, required this.referenceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 16.0, right: 8.0, left: 8.0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: (1),
        crossAxisSpacing: 8,
        mainAxisSpacing: 8,
      ),
      itemCount: referenceList.length,
      itemBuilder: (context, index) {
        final item = referenceList[index];
        return GestureDetector(
          onTap: () {
            openEpub(context: context, reference: item);
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
                            BlocProvider.of<BookmarkCubit>(context)
                                .deleteBookmark(item.id ?? 0);
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
                              item.title,
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
                  item.bookName,
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2,
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
