import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/web_view/cubit/webview_cubit.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:flutter/material.dart';

class WebViewCustom extends StatefulWidget {
  final String content;

  const WebViewCustom({Key? key, required this.content}) : super(key: key);

  @override
  State<WebViewCustom> createState() => _WebViewCustomState();
}

class _WebViewCustomState extends State<WebViewCustom> {
  late WebViewController _webViewController;
  late WebviewCubit webViewCubit;

  @override
  void initState() {
    super.initState();
    webViewCubit = WebviewCubit();
    _initContent(content: widget.content);
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
    return BlocBuilder<WebviewCubit, WebviewState>(
      builder: (context, state) {
        if (state is WebviewLoaded) {
          return WebViewWidget(
            controller: _webViewController
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(_buildNavigationDelegate())
              ..loadRequest(_buildInitialUrl(content: state.content)),
          );
        } else {
          return const Center(
            child: SizedBox(
              width: 20.0,
              height: 20.0,
              child: CircularProgressIndicator(),
            ),
          );
        }
      },
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

  Uri _buildInitialUrl({required String content}) {
    return Uri.dataFromString(
      content,
      mimeType: 'text/html',
      encoding: Encoding.getByName('utf-8'),
    );
  }

  void _initContent({required String content}) {
    BlocProvider.of<WebviewCubit>(context)
        .loadModifiedContent(content);
  }
}


