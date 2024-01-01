import 'dart:convert';
import 'dart:math';
import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/epub/cubit/epub_cubit.dart';
import 'package:ketub_platform/screens/epub/widgets/style_sheet.dart';
import 'package:ketub_platform/screens/epub/widgets/webview.dart';
import 'package:ketub_platform/utils/page_helper.dart';
import 'package:ketub_platform/utils/style_handler.dart';
import 'package:webview_flutter/webview_flutter.dart';

import '../../models/search_model.dart';
import '../../models/style_model.dart';
import '../../utils/style_helper.dart';
import 'internal_search/internal_search_screen.dart';
import 'internal_toc/internal_toc_screen.dart';

typedef DataCallback = void Function(dynamic data);

class EpubScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final CategoryModel? catModel;
  final EpubChaptersWithBookPath? tocModel;
  final SearchModel? searchModel;
  final DataCallback? onDataReceived;


  const EpubScreen(
      {Key? key,
      this.referenceModel,
      this.catModel,
      this.tocModel,
      this.onDataReceived,
        this.searchModel,
      })
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
  PageHelper pageHelper = PageHelper();
  double currentPage = 0;
  bool isSliderVisible = false;
  bool isBookmarked = false;
  EpubChapter? _chapter;
  List<EpubChapter>? tocList;
   String? _bookPath;
   final String _pathUrl = 'assets/epubs/';



  @override
  void initState() {
    super.initState();
    _determineEpubSourceAndLoad();
  }

  void _determineEpubSourceAndLoad() {
    if (widget.referenceModel != null) {
      _loadEpubFromBookmark();
    } else if (widget.tocModel != null) {
      _loadEpubFromTableOfContents();
    } else if (widget.searchModel != null) {
      _loadEpubFromSearchResult();
    } else {
      _loadEpubFromCategory();
    }
  }

  void _loadEpubFromBookmark() {
    final int bookmarkPageNumber = int.tryParse(widget.referenceModel?.navIndex ?? '') ?? 0;
    _pageController.jumpToPage(bookmarkPageNumber);
    _bookPath = widget.referenceModel!.bookPath;
    _loadAndParseEpub(bookPath: _bookPath!);
  }

  void _loadEpubFromTableOfContents() {
    _bookPath = widget.tocModel!.epubChapter.ContentFileName;
    _loadAndParseEpub(bookPath: widget.tocModel!.bookPath, fileName: _bookPath!);
  }

  void _loadEpubFromSearchResult() {
    _bookPath = widget.searchModel!.pageId;
    _loadAndParseEpub(bookPath: widget.searchModel!.bookAddress!, fileName: _bookPath!);
  }

  void _loadEpubFromCategory() {
    _bookPath = widget.catModel!.bookPath!;
    _loadAndParseEpub(bookPath: _bookPath!);
  }

  /// FileName for handling toc and search item to get number of section
  void _loadAndParseEpub({required String bookPath, String? fileName}) {
    BlocProvider.of<EpubCubit>(context)
        .loadAndParseEpub('$_pathUrl$bookPath', fileName);
  }
















  @override
  void dispose() {
    final pageHelper = PageHelper();
    pageHelper.saveBookData(widget.catModel!.bookPath!,currentPage);
    _pageController.dispose();
    super.dispose();
  }


  void toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }
  void _changeFontSize(FontSize fontSize) {
    // _webViewController
    //     ?.evaluateJavascript('changeFontSize("${fontSize.name}")');
  }

  void _changeLineSpace(LineSpace lineSpace) {
    // _webViewController
    //     ?.evaluateJavascript('changeLineSpace("${lineSpace.name}")');
  }

  void _changeFontFamily(FontFamily fontFamily) {
    // _webViewController
    //     ?.evaluateJavascript('changeFontFamily("${fontFamily.name}")');
  }

  // Check if WebView has no scroll
  void checkIfNoScroll() {
    // _webViewController?.evaluateJavascript('checkIfNoScroll()');
  }

  @override
  Widget build(BuildContext context) {
    _loadToc(context);
    if (_chapter != null) {
      BlocProvider.of<EpubCubit>(context).jumpToPage(_chapter!.ContentFileName);
    }
    if (!isSliderVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }


    return Scaffold(
      body: Stack(
        children: [
          if (isSliderVisible)
            AppBar(
              title: BlocBuilder<EpubCubit, EpubState>(
                builder: (context, state) {
                  if (state is EpubTitleLoadedState) {
                    _bookName = state.bookTitle;
                    return Text(_bookName.replaceAll('نصوص معاصرة', ''));
                  } else {
                    return Text('');
                  }
                },
                buildWhen: (previousState, state) {
                  return state is EpubTitleLoadedState;
                },
              ),
              actions: [
                IconButton(
                  icon: const Icon(Icons.search),
                  onPressed: () {
                    final epubCubit = BlocProvider.of<EpubCubit>(context);
                    Navigator.of(context).push(
                      MaterialPageRoute(
                        builder: (context) => InternalSearchScreen(
                          epubCubit: epubCubit,
                        ),
                      ),
                    );

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
                  icon: Icon(
                    isBookmarked ? Icons.bookmark : Icons.bookmark_border,
                  ),
                  onPressed: () {
                    // Toggle the bookmark state when the button is clicked
                    toggleBookmark();
                    if (isBookmarked) {
                      // Add bookmark logic
                      final reference = ReferenceModel(
                        title: 'sample title',
                        bookName: _bookName,
                        bookPath: widget.catModel!.bookPath!,
                        navIndex: currentPage.toString(),
                      );

                      BlocProvider.of<EpubCubit>(context)
                          .addBookmark(reference);
                    } else {
                      // Remove bookmark logic (if needed)
                    }
                  },
                ),
                BlocConsumer<EpubCubit, EpubState>(
                  listener: (context, state) {
                    if (state is ErrorState) {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(state.error.toString())));
                    } else if (state is TocItemTappedState) {}
                  },
                  builder: (context, state) {
                    return IconButton(
                      icon: const Icon(Icons.description_outlined),
                      onPressed: () {
                          final epubCubit = BlocProvider.of<EpubCubit>(context);
                          Navigator.of(context).push(
                            MaterialPageRoute(
                              builder: (context) => InternalToc(
                                tocList: tocList!,
                                onDataTransfer: (value) {
                                  setState(() {
                                    _chapter = value;
                                  });
                                },
                                epubCubit: epubCubit,
                              ),
                            ),
                          );
                      },
                    );
                  },
                ),
              ],
            ),
          Align(
            alignment: Alignment.topCenter,
            child: Container(
              margin: EdgeInsets.only(
                  top: !isSliderVisible
                      ? 0
                      : kToolbarHeight +
                          MediaQuery.of(context)
                              .padding
                              .top), // Adjust top margin based on visibility
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
                  else if (state is LastPageSeenChangedState) {
                    currentPage = state.page;
                  }
                  else if (state is EpubPageLoadedState) {
                    _pageController.jumpToPage(state.spineNumber!);
                  }
                  else if(state is TocLoadedState){
                    tocList = state.tocTreeList;
                  }

                },
                builder: (context, state) {
                  if (state is EpubLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  else if (state is EpubContentLoadedState) {
                    var allPagesCount = state.content.length.toDouble();
                    if (state.pageIndex != null) {
                      _pageController =
                          PageController(initialPage: state.pageIndex!.toInt());
                    }
                    else{
                      _pageController =
                          PageController(initialPage: currentPage.toInt());
                    }

                    return Row(
                      children: [
                        Expanded(
                          child: Column(
                            children: [
                              Expanded(
                                child: PageView.builder(
                                  controller: _pageController,
                                  scrollDirection: Axis.vertical,
                                  itemCount: state.content.length,
                                  // physics: _webViewIsScrolling
                                  //     ? const NeverScrollableScrollPhysics()
                                  //     : const AlwaysScrollableScrollPhysics(),
                                  itemBuilder: (context, index) {
                                    currentPage = index.toDouble();
                                    return WebViewCustom(content: state.content[index]);
                                  },
                                  onPageChanged: (index) {
                                    isBookmarked = false;
                                  },
                                ),
                              ),
                              if (isSliderVisible)
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
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
                                        epubCubit:
                                            BlocProvider.of<EpubCubit>(context), bookPath: _bookPath!,
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
                  return state is EpubContentLoadedState || state is EpubLoadingState;
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildWebView(String htmlContent) {
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
          behavior: HitTestBehavior.opaque,
          onTap: () {
            // Handle the single tap action here
            print('Single tap detected');
          },
          onDoubleTap: () {
            setState(() {
              isSliderVisible = !isSliderVisible;
            });
          },
          // child: WebView(
          //   initialUrl: '',
          //   javascriptMode: JavascriptMode.unrestricted,
          //   onWebViewCreated: (WebViewController webViewController) async {
          //     _webViewController = webViewController;
          //
          //     htmlContent = await injectCssJs(htmlContent);
          //
          //     webViewController.loadUrl(Uri.dataFromString(
          //       htmlContent,
          //       mimeType: 'text/html',
          //       encoding: Encoding.getByName('utf-8'),
          //     ).toString());
          //   },
          //   onPageFinished: (String url) {
          //     _changeFontFamily(styleHelper.fontFamily);
          //     _changeFontSize(styleHelper.fontSize);
          //     _changeLineSpace(styleHelper.lineSpace);
          //     // Call checkIfNoScroll with a delay after WebView content has loaded
          //     Future.delayed(Duration(milliseconds: 900), () {
          //       checkIfNoScroll();
          //     });
          //   },
          //   javascriptChannels: {
          //     JavascriptChannel(
          //       name: 'FLUTTER_CHANNEL',
          //       onMessageReceived: (message) {
          //         print('message is ${message.message}');
          //         if (message.message.toString() == 'end of scroll' ||
          //             message.message.toString() == 'no scroll') {
          //           setState(() {
          //             _webViewIsScrolling = false;
          //           });
          //         } else {
          //           setState(() {
          //             _webViewIsScrolling = true;
          //           });
          //         }
          //       },
          //     )
          //   },
          // ),
        );
      },
    );
  }

  void _showBottomSheet(BuildContext context, EpubCubit cubit) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true, // Set this property to true
      builder: (BuildContext context) {
        // Calculate the maximum height based on content
        double maxContentHeight = MediaQuery.of(context).size.height * 0.8;

        return ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: maxContentHeight,
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [
                // Your content goes here
                StyleSheet(epubCubit: cubit),
              ],
            ),
          ),
        );
      },
    );
  }



  _loadToc(BuildContext context) {
    BlocProvider.of<EpubCubit>(context).loadToc();
  }


}

class VerticalSeekBar extends StatefulWidget {
  double currentPage;
  double allPagesCount;
  EpubCubit epubCubit;
  String bookPath;

  VerticalSeekBar(
      {required this.currentPage,
      required this.allPagesCount,
      required this.epubCubit,
       required this.bookPath,
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
