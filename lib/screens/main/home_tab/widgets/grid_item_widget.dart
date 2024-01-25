import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class GridItemWidget extends StatefulWidget {
  final String title;
  final String imagePath;
  final double width;
  final double height;


  const GridItemWidget({Key? key, required this.title, required this.imagePath, required this.width, required this.height}) : super(key: key);

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: widget.width,
          height: widget.height,
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

