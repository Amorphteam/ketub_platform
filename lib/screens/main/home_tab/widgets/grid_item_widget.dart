import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatefulWidget {
  final String title;
  final String imagePath;


  const GridItemWidget({Key? key, required this.title, required this.imagePath}) : super(key: key);

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 80,
          height: 80,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(16), // Adjust the radius as needed
            image: DecorationImage(
              image: AssetImage(widget.imagePath),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(widget.title, style: Theme.of(context).textTheme.labelMedium,),
          ),
        ),
      ],
    );
  }
}

