import 'dart:convert';
import 'dart:math';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/book_model.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/epub/cubit/epub_cubit.dart';
import 'package:ketub_platform/screens/epub/widgets/style_sheet.dart';
import 'package:ketub_platform/utils/style_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/style_model.dart';
import '../../utils/style_helper.dart';

class EpubScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final CategoryModel? catModel;
  final EpubChaptersWithBookPath? tocModel;

  const EpubScreen(
      {Key? key, this.referenceModel, this.catModel, this.tocModel})
      : super(key: key);

  @override
  _EpubScreenState createState() => _EpubScreenState();
}

class _EpubScreenState extends State<EpubScreen> {
  late PageController _pageController;
  String _bookName = '';
  bool _webViewIsScrolling = true;
  WebViewController? _webViewController;
  StyleHelper styleHelper = StyleHelper();

  @override
  void initState() {
    super.initState();
    chackSourceOpenedFrom();
  }

  void chackSourceOpenedFrom() {
    if (widget.referenceModel !=null) { // Its from bookmark screen
      final int? bookMarkPageNumber = int.tryParse(widget.referenceModel?.navIndex ?? '');;
      _pageController = PageController(initialPage: bookMarkPageNumber ?? 0);
      _parseEpub(bookPath: widget.referenceModel!.bookPath);
    }else if (widget.tocModel != null){ // Its from toc
      _pageController = PageController();
      _parseEpub(bookPath: widget.tocModel!.bookPath, chapterFileName: widget.tocModel!.epubChapter.ContentFileName);
    }else { // its from library screen
      _pageController = PageController();
      _parseEpub(bookPath: widget.catModel!.bookPath!);
    }
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  void _changeFontSize(FontSize fontSize) {
    _webViewController
        ?.evaluateJavascript('changeFontSize("${fontSize.name}")');
  }

  void _changeLineSpace(LineSpace lineSpace) {
    _webViewController
        ?.evaluateJavascript('changeLineSpace("${lineSpace.name}")');
  }

  void _changeFontFamily(FontFamily fontFamily) {
    _webViewController
        ?.evaluateJavascript('changeFontFamily("${fontFamily.name}")');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: BlocBuilder<EpubCubit, EpubState>(
          builder: (context, state) {
            if (state is BookTitleLoadedState) {
              _bookName = state.bookTitle;
              return Text(_bookName.replaceAll('نصوص معاصرة', ''));
            } else {
              return Text('');
            }
          },
          buildWhen: (previousState, state) {
            return state is BookTitleLoadedState;
          },
        ),
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
                      if (state is EpubErrorState) {
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text(state.error)));
                      } else if (state is BookmarkAddedState){
                        ScaffoldMessenger.of(context)
                            .showSnackBar(SnackBar(content: Text('bookmark added successfully ${state.addStatus.toString()}')));
                      }
                    },
                    builder: (context, state) {
                      if (state is EpubLoadingState) {
                        return CircularProgressIndicator();
                      } else if (state is SpineLoadedState) {
                        if (state.spineNumber != null){
                          _pageController = PageController(initialPage: state.spineNumber!);
                        }
                        return PageView.builder(
                          controller: _pageController,
                          scrollDirection: Axis.vertical,
                          itemCount: state.spine.length,
                          physics: _webViewIsScrolling
                              ? const NeverScrollableScrollPhysics()
                              : const AlwaysScrollableScrollPhysics(),
                          itemBuilder: (context, index) {
                            var htmlWithCssJs = injectCssJs(state.spine[index]);
                            return buildWebView(htmlWithCssJs, index);
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
                    buildWhen: (previousState, state) {
                      return state is SpineLoadedState ||
                          state is EpubLoadingState;
                    },
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Text('12/233'),
                )
              ],
            ),
          ),
          VerticalSeekBar(),
        ],
      ),
    );
  }

  Widget buildWebView(String htmlContent, int currentPageNumber) {
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
        return GestureDetector(
            onDoubleTap: () {
              print('cat model is ${widget.catModel!.bookName!}');
              final reference = ReferenceModel(
                title: 'sample title',
                bookName: _bookName,
                bookPath: widget.catModel!.bookPath!,
                navIndex: currentPageNumber.toString(),
              );

              BlocProvider.of<EpubCubit>(context).addBookmark(reference);
            },
        child: WebView(
          initialUrl: '',
          javascriptMode: JavascriptMode.unrestricted,
          onWebViewCreated: (WebViewController webViewController) async {
            _webViewController = webViewController;

            String htmlWithFont = await addFontsToHtml(htmlContent);

            webViewController.loadUrl(Uri.dataFromString(
              htmlWithFont,
              mimeType: 'text/html',
              encoding: Encoding.getByName('utf-8'),
            ).toString());
          },
          onPageFinished: (String url) {
            _changeFontFamily(styleHelper.fontFamily);
            _changeFontSize(styleHelper.fontSize);
            _changeLineSpace(styleHelper.lineSpace);
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
        ),);
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

  void _parseEpub({required String bookPath, String? chapterFileName}) {
    BlocProvider.of<EpubCubit>(context).parseEpub('assets/epubs/$bookPath', chapterFileName);
  }


  String injectCssJs(String spine) {
    // Find the index of '</head>' in the HTML
    final headIndex = spine.indexOf('</head>');
    if (headIndex != -1) {
      // Insert the CSS link before '</head>'
      return spine.replaceRange(headIndex, headIndex, ketubCssJs);
    }
    return spine;
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
