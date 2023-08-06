import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpubScreen extends StatelessWidget {
  const EpubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    String htmlText = '<h1>Hello, this is some HTML text!</h1>'
        '<p>Here is some more content.</p>'
        '<p>You can add any valid HTML content here.</p>';

    return Scaffold(
      appBar: AppBar(
        actions: [
          IconButton(
            icon: const Icon(Icons.search),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button search was pressed!'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.tune_rounded),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button setting was pressed!'),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.bookmark_border),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button bookmark was pressed!'),
                ),
              );
            },
          ),
          IconButton(
            icon: Icon(Icons.description_outlined),
            onPressed: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Button toc was pressed!'),
                ),
              );
            },
          ),
        ],
      ),
      body: Row(
        children: [
          Expanded(
            child: WebView(
              initialUrl: '',
              onWebViewCreated: (WebViewController webViewController) {
                // Load HTML content when the WebView is created
                webViewController.loadUrl(Uri.dataFromString(
                  htmlText,
                  mimeType: 'text/html',
                  encoding: Encoding.getByName('utf-8'),
                ).toString());
              },
            ),
          ),
          const VerticalSeekBar(), // Add the vertical SeekBar here
        ],
      ),
    );
  }
}

class VerticalSeekBar extends StatefulWidget {
  const VerticalSeekBar({super.key});

  @override
  _VerticalSeekBarState createState() => _VerticalSeekBarState();
}

class _VerticalSeekBarState extends State<VerticalSeekBar> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1, // Rotate the SeekBar 90 degrees (bottom-up orientation)
      child: Slider(
        value: _sliderValue,
        onChanged: (newValue) {
          setState(() {
            _sliderValue = newValue;
          });
        },
      ),
    );
  }
}
