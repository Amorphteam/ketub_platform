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
      appBar: AppBar(title: Text('Book Name Here')),
      body: Container(
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
    );
  }
}
