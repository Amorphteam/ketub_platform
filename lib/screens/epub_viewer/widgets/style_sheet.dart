import 'package:flutter/material.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';

class StyleSheet extends StatefulWidget {
  final EpubViewerCubit epubViewerCubit;
  const StyleSheet({super.key, required this.epubViewerCubit});


  @override
  State<StyleSheet> createState() => _StyleSheetState();
}

class _StyleSheetState extends State<StyleSheet> {
  int _selectedChipIndex = -1;
  FontSizeCustom fontSizeCustom = FontSizeCustom.medium;
  FontFamily fontFamily = FontFamily.font1;
  LineHeightCustom lineSpace = LineHeightCustom.medium;

  void _handleChipSelection(int index) {
    setState(() {
      _selectedChipIndex = index;
    });
    FontFamily fontFamily;
    if (index == 0){
      fontFamily = FontFamily.font1;
    } else if (index == 1){
      fontFamily = FontFamily.font2;
    } else if (index == 2){
      fontFamily = FontFamily.font3;
    } else {
      fontFamily = FontFamily.font4;
    }
    this.fontFamily = fontFamily;
    widget.epubViewerCubit.changeStyle(lineSpace: lineSpace, fontSize: fontSizeCustom, fontFamily: fontFamily);
  }

  double _fontSizeSliderValue = 0.5;

  void _handleFontSizeSliderChange(double newValue) {
    setState(() {
      _fontSizeSliderValue = newValue;
    });

    FontSizeCustom fontSize;

    if (newValue <= 0.1) {
      fontSize = FontSizeCustom.xxSmall;
    } else if (newValue <= 0.2) {
      fontSize = FontSizeCustom.xSmall;
    } else if (newValue <= 0.4) {
      fontSize = FontSizeCustom.small;
    } else if (newValue <= 0.6) {
      fontSize = FontSizeCustom.medium;
    } else if (newValue <= 0.8) {
      fontSize = FontSizeCustom.large;
    } else if (newValue <= 0.9) {
      fontSize = FontSizeCustom.xLarge;
    } else {
      fontSize = FontSizeCustom.xxLarge;
    }
    fontSizeCustom = fontSize;
    widget.epubViewerCubit.changeStyle(lineSpace: lineSpace, fontSize: fontSizeCustom, fontFamily: fontFamily);
  }

  double _lineHeightSliderValue = 0.5; // Initialize with a default value

  void _handleLineHeightSliderChange(double newValue) {
    setState(() {
      _lineHeightSliderValue = newValue;
    });
    LineHeightCustom lineSpace;
    if (newValue <= 0.1) {
      lineSpace = LineHeightCustom.xxSmall;
    } else if (newValue <= 0.2) {
      lineSpace = LineHeightCustom.xSmall;
    } else if (newValue <= 0.4) {
      lineSpace = LineHeightCustom.small;
    } else if (newValue <= 0.6) {
      lineSpace = LineHeightCustom.medium;
    } else if (newValue <= 0.8) {
      lineSpace = LineHeightCustom.large;
    } else if (newValue <= 0.9) {
      lineSpace = LineHeightCustom.xLarge;
    } else {
      lineSpace = LineHeightCustom.xxLarge;
    }

    this.lineSpace = lineSpace;
    widget.epubViewerCubit.changeStyle(lineSpace: lineSpace, fontSize: fontSizeCustom, fontFamily: fontFamily);

  }

  Color _selectedColor = Colors.black; // Default color

  void _showColorPicker() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Pick a color'),
          content: SingleChildScrollView(
            child: ColorPicker(
              pickerColor: _selectedColor,
              onColorChanged: (color) {
                setState(() {
                  _selectedColor = color;
                });
              },
              pickerAreaHeightPercent: 0.8,
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // SizedBox(height: 16),
          // Text(
          //   'Text setting wizard',
          //   style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          // ),
          // SizedBox(height: 26),
          // Row(
          //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
          //   children: [
          //     Column(
          //       children: [
          //         IconButton(
          //           icon: Icon(Icons.contrast),
          //           onPressed: () {
          //
          //           },
          //         ),
          //         const Text(
          //           'High Contrast',
          //           style: TextStyle(fontSize: 10),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         IconButton(
          //           icon: Icon(Icons.dark_mode),
          //           onPressed: () {
          //
          //           },
          //         ),
          //         Text(
          //           'Dark Mode',
          //           style: TextStyle(fontSize: 10),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         IconButton(
          //           icon: Icon(Icons.zoom_out_map),
          //           onPressed: () {
          //             _handleFontSizeSliderChange(0.8);
          //             _handleLineHeightSliderChange(0.8);
          //           },
          //         ),
          //         Text(
          //           'More readability',
          //           style: TextStyle(fontSize: 10),
          //         ),
          //       ],
          //     ),
          //     Column(
          //       children: [
          //         IconButton(
          //           icon: Icon(Icons.article),
          //           onPressed: () {
          //           },
          //         ),
          //         Text(
          //           'High Contrast',
          //           style: TextStyle(fontSize: 10),
          //         ),
          //       ],
          //     ),
          //   ],
          // ),
          // SizedBox(height: 18,),
          // Divider(), // Add a divider here

          SizedBox(height: 18,),
          Text('Text Settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 18), // Add spacing before the Chip widgets

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              InputChip(
                label: Text('font 1'),
                selected: _selectedChipIndex == 0,
                onSelected: (isSelected) {
                  _handleChipSelection(isSelected ? 0 : -1);
                },
              ),
              InputChip(
                label: Text('font 2'),
                selected: _selectedChipIndex == 1,
                onSelected: (isSelected) {
                  _handleChipSelection(isSelected ? 1 : -1);
                },
              ),
              InputChip(
                label: Text('font 3'),
                selected: _selectedChipIndex == 2,
                onSelected: (isSelected) {
                  _handleChipSelection(isSelected ? 2 : -1);
                },
              ),
              InputChip(
                label: Text('font 4'),
                selected: _selectedChipIndex == 3,
                onSelected: (isSelected) {
                  _handleChipSelection(isSelected ? 3 : -1);
                },
              ),
            ],
          ),

          SizedBox(height: 26), // Add spacing between the Chip and Slider widgets

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  divisions: FontSizeCustom.values.length - 1,
                  value: _fontSizeSliderValue,
                  onChanged: _handleFontSizeSliderChange,
                ),
              ),
              const Icon(Icons.text_increase, size: 18, color: Colors.grey,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  divisions: LineHeightCustom.values.length - 1,
                  value: _lineHeightSliderValue,
                  onChanged: _handleLineHeightSliderChange,
                ),
              ),
              Icon(Icons.format_line_spacing, size: 18, color: Colors.grey,),
            ],
          ),
          // IconButton(
          //   icon: Icon(Icons.color_lens),
          //   onPressed: _showColorPicker,
          // ),
        ],
      ),


    );
  }
}
