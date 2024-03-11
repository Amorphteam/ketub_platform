import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GridItemWidget extends StatefulWidget {
  final String title;
  final String imagePath;
  final double width;
  final double height;
  final bool withTitle;
  final bool insideTitlePosition;
  final bool? withBk;
  final bool isAudio;

  const GridItemWidget({
    Key? key,
    this.insideTitlePosition = true,
    this.withTitle = true,
    required this.title,
    required this.imagePath,
    required this.width,
    required this.height, this.withBk,
    this.isAudio = false,
  }) : super(key: key);

  @override
  State<GridItemWidget> createState() => _GridItemWidgetState();
}

class _GridItemWidgetState extends State<GridItemWidget> {
  @override
  Widget build(BuildContext context) {
    Widget imageContainer = Stack(
      alignment: Alignment.center,
      children: [
        Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          image: DecorationImage(
            image: AssetImage(widget.imagePath),
            fit: BoxFit.cover,
          ),
        ),
      ),
        (widget.isAudio) ? SvgPicture.asset(
          'assets/icons/audio.svg',
          color: Colors.white,
        ): Container(),]
    );

    Widget? titleText = widget.withTitle ? Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(widget.title, style: Theme.of(context).textTheme.labelMedium),
    ) : null;

    // Use a ternary operator to decide between Row and Column
    return widget.insideTitlePosition
        ? Container(
      decoration: BoxDecoration(
        color: widget.withBk ?? false ? Colors.grey[200] : null,
        borderRadius: BorderRadius.circular(16), // Set rounded corners
      ),
      padding: const EdgeInsets.all(8.0),
      child: Row(
        children: [
          imageContainer,
          if (widget.withTitle) Expanded(child: titleText!),
        ],
      ),
    )
        : Column(
      children: [
        imageContainer,
        if (widget.withTitle) Expanded(child: Center(child: titleText!)),
      ],
    );

  }
}
