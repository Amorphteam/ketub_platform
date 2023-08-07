import 'package:flutter/material.dart';

import '../models/toc_model.dart';

class TocListWidget extends StatelessWidget {
  final List<TocGroupItem> tocList;

  const TocListWidget({Key? key, required this.tocList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: tocList.length,
      itemBuilder: (context, index) {
        TocGroupItem groupItem = tocList[index];
        return Padding(
          padding: const EdgeInsets.only(left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
                 Text(groupItem.bookTitle,),

              SizedBox(height: 8),
              Text(
                groupItem.bookName,
                style: TextStyle(
                  fontSize: 14,
                  color: Colors.grey,
                ),
              ),
              SizedBox(height: 8),
              ListView.builder(
                shrinkWrap: true,
                physics: ClampingScrollPhysics(),
                itemCount: groupItem.childItems.length,
                itemBuilder: (context, childIndex) {
                  TocFirstChildItem firstChildItem = groupItem.childItems[childIndex];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        firstChildItem.bookTitle,
                      ),
                      SizedBox(height: 8),
                      Text(
                        firstChildItem.bookName,
                        style: TextStyle(
                          fontSize: 12,
                          color: Colors.red,
                        ),
                      ),
                      SizedBox(height: 8),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: ClampingScrollPhysics(),
                        itemCount: firstChildItem.childItems2.length,
                        itemBuilder: (context, secondChildIndex) {
                          TocSecondChildItem secondChildItem = firstChildItem.childItems2[secondChildIndex];
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                secondChildItem.bookTitle,
                              ),
                              SizedBox(height: 8),
                              Text(
                                secondChildItem.bookName,
                                style: TextStyle(
                                  fontSize: 10,
                                  color: Colors.red,
                                ),
                              ),
                              SizedBox(height: 16),
                            ],
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        );
      },
    );
  }
}