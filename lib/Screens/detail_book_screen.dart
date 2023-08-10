import 'package:flutter/material.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
class DetailBookScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final BookModel? bookModel;

  const DetailBookScreen({Key? key, this.referenceModel, this.bookModel}) : super(key: key);

  @override
  _DetailBookScreenState createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: Theme.of(context),
      child: SafeArea(
        child: Container(
          padding: EdgeInsets.all(16),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (widget.referenceModel != null)
                  Text(widget.referenceModel!.id.toString()),
                if (widget.referenceModel != null)
                  Text(widget.referenceModel!.title?.toString() ?? ''),
                if (widget.bookModel != null)
                  Text(widget.bookModel!.id.toString()),
                if (widget.bookModel != null)
                  Text(widget.bookModel!.bookName?.toString() ?? ''),
              ],
            ),
          ),
        ),
      ),
    );
  }
}