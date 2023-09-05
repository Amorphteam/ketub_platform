import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/epub/cubit/epub_cubit.dart';
import 'package:ketub_platform/screens/epub/widgets/style_sheet.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EpubScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final BookModel? bookModel;
  final TreeTocModel? tocModel;

  const EpubScreen(
      {Key? key, this.referenceModel, this.bookModel, this.tocModel})
      : super(key: key);

  @override
  _EpubScreenState createState() => _EpubScreenState();
}

class _EpubScreenState extends State<EpubScreen> {
  late PageController _pageController;
  bool _webViewIsScrolling = true;
  WebViewController? _webViewController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController();
    _parseEpub();
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changeFontSize(String className) {
    _webViewController?.evaluateJavascript('changeFontSize("$className")');
  }

  void _changeLineSpace(String className) {
    _webViewController?.evaluateJavascript('changeLineSpace("$className")');
  }

  void _changeFontFamily(String className) {
    _webViewController?.evaluateJavascript('changeFontFamily("$className")');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Epub Screen'),
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
              final epubCubit = BlocProvider.of<EpubCubit>(context);
              _showBottomSheet(context, epubCubit);
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
            icon: const Icon(Icons.description_outlined),
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
            child: Column(
              children: [
                Expanded(
                  child: BlocConsumer<EpubCubit, EpubState>(
                    listener: (context, state) {
                      if (state is EpubErrorState){
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(state.error)));
                      }
                    },
                    builder: (context, state) {
                      if (state is EpubLoadingState){
                        return CircularProgressIndicator();
                      } else if (state is SpineEpubLoadedState){
                      return PageView.builder(
                        controller: _pageController,
                        scrollDirection: Axis.vertical,
                        itemCount: state.spine.length,
                        physics: _webViewIsScrolling
                            ? const NeverScrollableScrollPhysics()
                            : const AlwaysScrollableScrollPhysics(),
                        itemBuilder: (context, index) {
                          return buildWebView(state.spine[index]);
                        },
                        onPageChanged: (index) {
                          setState(() {
                            _webViewIsScrolling = true;
                          });
                        },
                      );
                      } else {
                        return Placeholder();
                      }
                    },
                    buildWhen: (previousState, state){
                      return state is SpineEpubLoadedState || state is EpubLoadingState;
                    },
                  ),
                ),
                const Padding(
                    padding: EdgeInsets.all(20), child: Text('12/344'))
              ],
            ),
          ),
          VerticalSeekBar(),
        ],
      ),
    );
  }

  Widget buildWebView(String htmlContent) {
    return BlocConsumer<EpubCubit, EpubState>(
      listener: (context, state) {
        if (state is FontSizeChangedState) {
          _changeFontSize(state.fontSize.name);
        } else if (state is LineSpaceChangedState) {
          _changeLineSpace(state.lineSpace.name);
        } else if (state is FontFamilyChangedState) {
          _changeFontFamily(state.fontFamily.name);
        }
      },
      builder: (context, state) {
        return WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) {
            _webViewController = webViewController;
            webViewController.loadUrl(Uri.dataFromString(
              htmlContent,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString());
          },
          javascriptChannels: {
            JavascriptChannel(
              name: 'FLUTTER_CHANNEL',
              onMessageReceived: (message) {
                if (message.message.toString() == 'end of scroll') {
                  setState(() {
                    _webViewIsScrolling = false;
                  });
                }
              },
            )
          },
          gestureNavigationEnabled: true,
          debuggingEnabled: true,
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, EpubCubit cubit) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return StyleSheet(epubCubit: cubit);
      },
    );
  }

  void _parseEpub() {
    BlocProvider.of<EpubCubit>(context).parseEpub('assets/epubs/57.epub');
  }

}

class VerticalSeekBar extends StatefulWidget {
  const VerticalSeekBar({Key? key}) : super(key: key);

  @override
  _VerticalSeekBarState createState() => _VerticalSeekBarState();
}

class _VerticalSeekBarState extends State<VerticalSeekBar> {
  double _sliderValue = 0.5;

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 1,
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
