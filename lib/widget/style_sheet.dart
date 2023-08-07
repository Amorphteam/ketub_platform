import 'package:flutter/material.dart';

class StyleSheet extends StatefulWidget {
  const StyleSheet({super.key});

  @override
  State<StyleSheet> createState() => _StyleSheetState();
}

class _StyleSheetState extends State<StyleSheet> {
  int _selectedChipIndex = -1; // Initialize with an invalid index

  void _handleChipSelection(int index) {
    setState(() {
      _selectedChipIndex = index;
    });
  }

  double _fontSizeSliderValue = 0.5; // Initialize with a default value

  void _handleFontSizeSliderChange(double newValue) {
    setState(() {
      _fontSizeSliderValue = newValue;
    });
  }

  double _lineHeightSliderValue = 0.5; // Initialize with a default value

  void _handlelineHeightSliderChange(double newValue) {
    setState(() {
      _lineHeightSliderValue = newValue;
    });
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.all(16.0),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Text(
            'Text setting wizard',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 26),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.contrast),
                    onPressed: () {

                    },
                  ),
                  const Text(
                    'High Contrast',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.dark_mode),
                    onPressed: () {

                    },
                  ),
                  Text(
                    'Dark Mode',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.zoom_out_map),
                    onPressed: () {

                    },
                  ),
                  Text(
                    'More readability',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
              Column(
                children: [
                  IconButton(
                    icon: Icon(Icons.article),
                    onPressed: () {

                    },
                  ),
                  Text(
                    'High Contrast',
                    style: TextStyle(fontSize: 10),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 26,),
          Divider(), // Add a divider here

          SizedBox(height: 26,),
          Text('Advanced settings', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),),
          SizedBox(height: 26), // Add spacing before the Chip widgets

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
                  value: _fontSizeSliderValue,
                  onChanged: _handleFontSizeSliderChange,
                ),
              ),
              Icon(Icons.text_increase, size: 18, color: Colors.grey,),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: Slider(
                  value: _lineHeightSliderValue,
                  onChanged: _handlelineHeightSliderChange,
                ),
              ),
              Icon(Icons.format_line_spacing, size: 18, color: Colors.grey,),
            ],
          ),
        ],
      ),
    );
  }
}
