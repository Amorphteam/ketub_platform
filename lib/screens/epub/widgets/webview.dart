import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:ketub_platform/utils/style_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

class WebViewCustom extends StatefulWidget {
  String content;
  WebViewCustom({super.key, required this.content});

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  @override
  Widget build(BuildContext context) {
    return WebView(
      initialUrl: '',
      javascriptMode: JavascriptMode.unrestricted,
      onWebViewCreated: (WebViewController webViewController) async {

        webViewController.loadUrl(Uri.dataFromString(
          widget.content = await injectCssJs(widget.content),
          mimeType: 'text/html',
          encoding: Encoding.getByName('utf-8'),
        ).toString());
      },

    );
  }
}
