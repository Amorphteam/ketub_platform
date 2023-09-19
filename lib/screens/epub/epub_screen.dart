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
  double currentPage = 0;
  bool isSliderVisible = false;

  @override
  void initState() {
    super.initState();
    chackSourceOpenedFrom();
  }

  void chackSourceOpenedFrom() {
    if (widget.referenceModel != null) {
      // It's from the bookmark screen
      final int? bookMarkPageNumber =
      int.tryParse(widget.referenceModel?.navIndex ?? '');
      _pageController = PageController(initialPage: bookMarkPageNumber ?? 0);
      _parseEpub(bookPath: widget.referenceModel!.bookPath);
    } else if (widget.tocModel != null) {
      // It's from the table of contents (TOC)
      _pageController = PageController();
      _parseEpub(
          bookPath: widget.tocModel!.bookPath,
          chapterFileName: widget.tocModel!.epubChapter.ContentFileName);
    } else {
      // It's from the library screen
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


  // Check if WebView has no scroll
  void checkIfNoScroll() {
    _webViewController?.evaluateJavascript('checkIfNoScroll()');
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          if (isSliderVisible)
            AppBar(
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
                    // Toggle the visibility of the slider
                    setState(() {
                      isSliderVisible = !isSliderVisible;
                    });
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
          Align(
            alignment: Alignment.topCenter,
            child: Container(

              margin: EdgeInsets.only(top: !isSliderVisible ? MediaQuery.of(context).padding.top : kToolbarHeight+MediaQuery.of(context).padding.top), // Adjust top margin based on visibility
              child: BlocConsumer<EpubCubit, EpubState>(
                listener: (context, state) {
                  if (state is EpubErrorState) {
                    ScaffoldMessenger.of(context)
                        .showSnackBar(SnackBar(content: Text(state.error)));
                  } else if (state is BookmarkAddedState) {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        content: Text(
                            'bookmark added successfully ${state.addStatus.toString()}')));
                  } else if (state is PageChangedState) {
                    currentPage = state.newPage.toDouble();
                    _pageController.jumpToPage(state.newPage);
                  }
                },
                builder: (context, state) {
                  if (state is EpubLoadingState) {
                    return CircularProgressIndicator();
                  } else if (state is SpineLoadedState) {
                    var allPagesCount = state.spine.length.toDouble();
                    if (state.spineNumber != null) {
                      _pageController = PageController(initialPage: state.spineNumber!);
                    }
                    _pageController = PageController(initialPage: currentPage.toInt());
                    print(' wwebView is $_webViewIsScrolling');
                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.spine.length,
                                  physics: _webViewIsScrolling
                                      ? const NeverScrollableScrollPhysics()
                                      : const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    currentPage = index.toDouble();
                                    return buildWebView(state.spine[index], index);
                                  },
                                  onPageChanged: (index) {
                                      setState(() {
                                        _webViewIsScrolling = true;
                                      });
                                  },
                                ),
                              ),
                              if (isSliderVisible)
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.all(20.0),
                                      child: Text(
                                          '${currentPage.toInt()}/${allPagesCount.toInt()}'),
                                    ),
                                    Expanded(
                                      child: VerticalSeekBar(
                                        currentPage: currentPage,
                                        allPagesCount: allPagesCount,
                                        epubCubit: BlocProvider.of<EpubCubit>(context),
                                      ),
                                    ),
                                  ],
                                )
                            ],
                          ),
                        ),
                      ],
                    );
                  } else {
                    return Placeholder();
                  }
                },
                buildWhen: (previousState, state) {
                  return state is SpineLoadedState || state is EpubLoadingState;
                },
              ),
            ),
          ),
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
            final reference = ReferenceModel(
              title: 'sample title',
              bookName: _bookName,
              bookPath: widget.catModel!.bookPath!,
              navIndex: currentPageNumber.toString(),
            );

            BlocProvider.of<EpubCubit>(context).addBookmark(reference);
          },
          onTapDown: (TapDownDetails tapDownDetails){
            setState(() {
              isSliderVisible = !isSliderVisible;
            });
            },
          child: WebView(
            initialUrl: '',
            javascriptMode: JavascriptMode.unrestricted,
            onWebViewCreated: (WebViewController webViewController) async {
              _webViewController = webViewController;

              htmlContent = await injectCssJs(htmlContent);

              webViewController.loadUrl(Uri.dataFromString(
                htmlContent,
                mimeType: 'text/html',
                encoding: Encoding.getByName('utf-8'),
              ).toString());
            },
            onPageFinished: (String url) {
              _changeFontFamily(styleHelper.fontFamily);
              _changeFontSize(styleHelper.fontSize);
              _changeLineSpace(styleHelper.lineSpace);
                checkIfNoScroll();

            },
            javascriptChannels: {
              JavascriptChannel(
                name: 'FLUTTER_CHANNEL',
                onMessageReceived: (message) {
                  print('message is ${message.message}');
                  if (message.message.toString() == 'end of scroll' || message.message.toString() == 'no scroll') {
                    setState(() {
                      _webViewIsScrolling = false;
                    });
                  }else {
                    setState(() {
                      _webViewIsScrolling = true;
                    });
                  }

                },
              )
            },
            gestureNavigationEnabled: true,
            debuggingEnabled: true,
          ),
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

  void _parseEpub({required String bookPath, String? chapterFileName}) {
    BlocProvider.of<EpubCubit>(context)
        .parseEpub('assets/epubs/$bookPath', chapterFileName);
  }

  Future<String> injectCssJs(String spine) async {
    // Find the index of '</head>' in the HTML
    final headIndex = spine.indexOf('</head>');
    if (headIndex != -1) {
      // Insert the CSS link before '</head>'
      final spineWithCss = spine.replaceRange(headIndex, headIndex, ketubCssJs);
      final spineWithFont = await addFontsToHtml(spineWithCss);
      return spineWithFont;
    }
    return spine;
  }
}

class VerticalSeekBar extends StatefulWidget {
  double currentPage;
  double allPagesCount;
  EpubCubit epubCubit;

  VerticalSeekBar(
      {required this.currentPage,
        required this.allPagesCount,
        required this.epubCubit,
        Key? key})
      : super(key: key);

  @override
  _VerticalSeekBarState createState() => _VerticalSeekBarState();
}

class _VerticalSeekBarState extends State<VerticalSeekBar> {
  double _currentValue = 0;

  @override
  void initState() {
    super.initState();
    _currentValue = widget.currentPage;
  }

  @override
  Widget build(BuildContext context) {
    return RotatedBox(
      quarterTurns: 2,
      child: Slider(
        value: _currentValue,
        onChangeEnd: (newValue) {
          widget.epubCubit.changePage(newValue.toInt());
        },
        onChanged: (newValue) {
          setState(() {
            _currentValue = newValue;
          });
        },
        max: widget.allPagesCount,
        min: 0,
      ),
    );
  }
}
