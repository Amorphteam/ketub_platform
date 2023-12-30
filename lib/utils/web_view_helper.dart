import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:flutter/material.dart';

class WebViewHelper extends StatefulWidget {
  final String content;

  WebViewHelper({Key? key, required this.content}) : super(key: key);

  @override
  State<WebViewHelper> createState() => _WebViewHelperState();
}

class _WebViewHelperState extends State<WebViewHelper> {
  late WebViewController _webViewController;

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
  }

  void _initializeWebViewController() {
    if (WebViewPlatform.instance is WebKitWebViewPlatform) {
      final params = WebKitWebViewControllerCreationParams(
        allowsInlineMediaPlayback: true,
        mediaTypesRequiringUserAction: const <PlaybackMediaTypes>{},
      );
      _webViewController = WebViewController.fromPlatformCreationParams(params);
    } else {
      _webViewController = WebViewController();
    }
  }

  @override
  Widget build(BuildContext context) {
    return WebViewWidget(
      controller: _webViewController
        ..setJavaScriptMode(JavaScriptMode.unrestricted)
        ..setNavigationDelegate(_buildNavigationDelegate())
        ..loadRequest(_buildInitialUrl()),
    );
  }

  NavigationDelegate _buildNavigationDelegate() {
    return NavigationDelegate(
      onProgress: (int progress) {
        debugPrint('WebView is loading (progress : $progress%)');
      },
      onPageStarted: (String url) {
        debugPrint('Page started loading: $url');
      },
      onPageFinished: (String url) {
        if (_webViewController.platform is AndroidWebViewController) {
          AndroidWebViewController.enableDebugging(true);
          (_webViewController.platform as AndroidWebViewController)
              .setMediaPlaybackRequiresUserGesture(false);
        }
      },
      onWebResourceError: (WebResourceError error) {
        debugPrint('''
          Page resource error:
          code: ${error.errorCode}
          description: ${error.description}
          errorType: ${error.errorType}
          isForMainFrame: ${error.isForMainFrame}
        ''');
      },
      onUrlChange: (UrlChange change) {
        debugPrint('url change to ${change.url}');
      },
    );
  }

  Uri _buildInitialUrl() {
    return Uri.dataFromString(
      widget.content,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );
  }
}
