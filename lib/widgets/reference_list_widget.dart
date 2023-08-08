import 'package:flutter/material.dart';
import 'package:ketub_platform/models/reference_model.dart';


class ReferenceListWidget extends StatelessWidget {
  final List<ReferenceModel> referenceList;

  const ReferenceListWidget({Key? key, required this.referenceList}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: referenceList.length,
      itemBuilder: (context, index) {
        ReferenceModel item = referenceList[index] ;
        return ListTile(
          title: Text(item.title,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.black)),
          subtitle:Text(item.bookName,style: Theme.of(context).textTheme.bodySmall?.copyWith(color: Colors.grey)) ,
          trailing: Icon(Icons.delete),
        );
      },
    );
  }
}


