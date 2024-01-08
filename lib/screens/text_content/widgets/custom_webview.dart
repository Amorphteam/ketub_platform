import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_android/webview_flutter_android.dart';
import 'package:webview_flutter_wkwebview/webview_flutter_wkwebview.dart';

import 'package:flutter/material.dart';

import '../../../models/style_model.dart';
import '../../../utils/style_helper.dart';
import '../epub/cubit/epub_cubit.dart';

class CustomWebView extends StatefulWidget {
  final String content;
  final EpubCubit? epubCubit;

  const CustomWebView({Key? key, required this.content, this.epubCubit});

  @override
  State<CustomWebView> createState() => _CustomWebViewState();
}

class _CustomWebViewState extends State<CustomWebView> {
  late WebViewController _webViewController;
  StyleHelper styleHelper = StyleHelper();

  @override
  void initState() {
    super.initState();
    _initializeWebViewController();
    _initContent();
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

    return BlocConsumer<EpubCubit, EpubState>(
      listener: (context, state) {
        if (state is FontSizeChangedState) {
          _changeFontSize(state.fontSize);
        } else if (state is LineSpaceChangedState) {
          _changeLineSpace(state.lineSpace);
        } else if (state is FontFamilyChangedState) {
          _changeFontFamily(state.fontFamily);
        }
      },
      builder: (context, state) {
        if (state is EpubContentWithCssLoadedState) {
          return WebViewWidget(
            controller: _webViewController
              ..setJavaScriptMode(JavaScriptMode.unrestricted)
              ..setNavigationDelegate(_buildNavigationDelegate())
              ..loadRequest(_buildInitialUrl(content: state.content)),
          );
        } else if (state is ErrorState) {
          return Text(state.error.toString());
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
      buildWhen: (previousState, state) {
        return state is EpubContentWithCssLoadedState || state is EpubLoadingState;
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

            _changeFontFamily(styleHelper.fontFamily);
            _changeFontSize(styleHelper.fontSize);
            _changeLineSpace(styleHelper.lineSpace);

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

  void _initContent() {
    widget.epubCubit?.loadModifiedContent(widget.content);
  }

  void _changeFontSize(FontSize fontSize) {
    _webViewController.runJavaScript('changeFontSize("${fontSize.name}")');
  }

  void _changeLineSpace(LineSpace lineSpace) {
    _webViewController.runJavaScript('changeLineSpace("${lineSpace.name}")');
  }

  void _changeFontFamily(FontFamily fontFamily) {
    _webViewController.runJavaScript('changeFontFamily("${fontFamily.name}")');
  }
}
