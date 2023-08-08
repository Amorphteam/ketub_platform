import 'package:flutter/material.dart';
import 'package:ketub_platform/models/reference_model.dart';

class DetailBookScreen extends StatefulWidget {
  final ReferenceModel referenceModel;

  const DetailBookScreen({Key? key, required this.referenceModel}) : super(key: key);

  @override
  _DetailBookScreenState createState() => _DetailBookScreenState();
}

class _DetailBookScreenState extends State<DetailBookScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        padding: EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(widget.referenceModel.id.toString()),
              Text(widget.referenceModel.title.toString()),

            ],
          ),
        ),
      ),
    );
  }
}
