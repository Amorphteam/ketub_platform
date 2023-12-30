import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewHelper extends StatefulWidget {
  String content;
  WebViewHelper({super.key, required this.content});

  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {

        webViewController.loadUrl(Uri.dataFromString(
          widget.content,
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },

    );
  }
}
