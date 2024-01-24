import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/search_model.dart';
import 'package:ketub_platform/models/style_model.dart';
import 'package:ketub_platform/models/tree_toc_model.dart';
import 'package:ketub_platform/screens/epub_viewer/cubit/epub_viewer_cubit.dart';
import 'package:ketub_platform/screens/epub_viewer/widgets/vertical_seekbar.dart';
import 'package:ketub_platform/utils/page_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import 'cubit/epub_cubit.dart';
import 'internal_search/internal_search_screen.dart';
import 'internal_toc/internal_toc_screen.dart';
import 'widgets/style_sheet.dart';

typedef DataCallback = void Function(dynamic data);

class EpubViewerScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final CategoryModel? catModel;
  final EpubChaptersWithBookPath? tocModel;
  final SearchModel? searchModel;
  final DataCallback? onDataReceived;

  const EpubViewerScreen({
    Key? key,
    this.referenceModel,
    this.catModel,
    this.tocModel,
    this.onDataReceived,
    this.searchModel,
  }) : super(key: key);

  @override
  _EpubViewerScreenState createState() => _EpubViewerScreenState();
}

class _EpubViewerScreenState extends State<EpubViewerScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
      ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
      ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
      ScrollOffsetListener.create();
  String _bookName = '';
  PageHelper pageHelper = PageHelper();
  double _currentPage = 0;
  bool isSliderVisible = true;
  bool isBookmarked = false;
  EpubChapter? _chapter;
  List<EpubChapter>? tocList;
  String? _bookPath;
  FontSizeCustom fontSize = FontSizeCustom.normalFontSize;
  LineSpace lineHeight = LineSpace.normalLineSpace;
  FontFamily fontFamily = FontFamily.font1;
  final String _pathUrl = 'assets/epubs/';
  List<String> _content = [];

  @override
  Widget build(BuildContext context) {
    _loadToc(context);
    if (_chapter != null) {
      context
          .read<EpubViewerCubit>()
          .jumpToPage(chapterFileName: _chapter!.ContentFileName);
    }
    if (!isSliderVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }

    return BlocConsumer<EpubViewerCubit, EpubViewerState>(
      listener: (context, state) {},
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (isSliderVisible)
                AppBar(
                  actions: [
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/search.svg'),
                      onPressed: () {
                        _openInternalSearch(context);
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/style.svg'),
                      onPressed: () {
                        _showBottomSheet(
                            context, context.read<EpubViewerCubit>());
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset(
                        isBookmarked
                            ? 'assets/icons/bookmarked.svg'
                            : 'assets/icons/bookmark.svg',
                      ),
                      onPressed: () {
                        _toggleBookmark();
                        if (isBookmarked) {
                          _addBookmark(context);
                        } else {
                          // Remove bookmark logic (if needed)
                        }
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/toc.svg'),
                      onPressed: () {
                        _openIternalToc(context);
                      },
                    )
                  ],
                ),
              Align(
                alignment: Alignment.topCenter,
                child: Container(
                  margin: EdgeInsets.only(
                      top: !isSliderVisible
                          ? 0
                          : kToolbarHeight +
                              MediaQuery.of(context).padding.top),
                  child: state.when(
                      loaded: (content, _) {
                        _storeContentLoaded(content, context, state);
                        context.read<EpubViewerCubit>().emitLastPageSeen();
                        return _buildCurrentUi(context, state);
                      },
                      loading: () => const Center(
                            child: CircularProgressIndicator(),
                          ),
                      error: (error) => _buildCurrentUi(context, state),
                      initial: () => Container(),
                      pageChanged: (int? pageNumber) {
                        _jumpTo(pageNumber: pageNumber);
                        _storeCurrentPage(currentPageNumber: pageNumber);
                        return _buildCurrentUi(context, state);
                      },
                      styleChanged: (FontSizeCustom? fontSize,
                          LineSpace? lineHeight, FontFamily? fontFamily) {
                        _changeStyle(fontSize, lineHeight, fontFamily);
                        return _buildCurrentUi(context, state);
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _storeContentLoaded(
      List<String> htmlContent, BuildContext context, EpubViewerState state) {
    _content = htmlContent;
    _bookName = _getAppBarTitle(state);
  }

  Row _buildCurrentUi(BuildContext context, EpubViewerState state) {
    var allPagesCount = _content.length.toDouble();
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ScrollablePositionedList.builder(
                    itemCount: _content.length,
                    itemScrollController: itemScrollController,
                    scrollOffsetController: scrollOffsetController,
                    itemPositionsListener: itemPositionsListener,
                    scrollOffsetListener: scrollOffsetListener,
                    itemBuilder: (BuildContext context, int index) {
                      _storeCurrentPage(currentPageNumber: index);
                      return Padding(
                        padding: const EdgeInsets.only(top: 20.0),
                        child: GestureDetector(
                          onDoubleTap: () {
                            setState(() {
                              isSliderVisible = !isSliderVisible;
                            });
                          },
                          onLongPress: () {
                            setState(() {
                              isSliderVisible = !isSliderVisible;
                            });
                          },
                          child: Container(
                            color: Colors.white,
                            child: SingleChildScrollView(
                              child: Html(
                                data: _content[index],
                                style: {
                                  "html": Style(
                                      textAlign: TextAlign.justify,
                                      direction: TextDirection.rtl,
                                      fontSize: FontSize.large,
                                      padding: HtmlPaddings.only(
                                          right: 10, left: 10),
                                      fontFamily: fontFamily.name),
                                  "h1,h2,h3": Style(
                                      textAlign: TextAlign.right,
                                      direction: TextDirection.rtl,
                                      padding: HtmlPaddings.only(top: 30),
                                      fontSize: FontSize.xLarge,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: fontFamily.name),
                                  "p": Style(
                                    lineHeight: LineHeight(1.7),
                                  )
                                },
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
              if (isSliderVisible)
              Column(
                  children: [
                    VerticalSeekBar(
                      currentPage: _currentPage,
                      allPagesCount: allPagesCount,
                      epubViewerCubit: context.read<EpubViewerCubit>(),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(
                          right: 16.0, left: 16.0, bottom: 8.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                              child: Text(
                            _bookName,
                            style: Theme.of(context).textTheme.labelMedium,
                          )),
                          Text(
                            '${_currentPage.toInt()}/${allPagesCount.toInt()}',
                            style: Theme.of(context).textTheme.labelMedium,
                          ),
                        ],
                      ),
                    ),
                  ],
                )
            ],
          ),
        ),
      ],
    );
  }

  _openInternalSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InternalSearchScreen(
          epubViewerCubit: context.read<EpubViewerCubit>(),
        ),
      ),
    );

    setState(() {
      isSliderVisible = !isSliderVisible;
    });
  }

  _addBookmark(BuildContext context) {
    final reference = ReferenceModel(
      title: 'sample title',
      bookName: _bookName,
      bookPath: widget.catModel!.bookPath!,
      navIndex: _currentPage.toString(),
    );

    // BlocProvider.of<EpubCubit>(context)
    //     .addBookmark(reference);
  }

  _openIternalToc(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => InternalToc(
          tocList: tocList!,
          onDataTransfer: (value) {
            setState(() {
              _chapter = value;
            });
          },
          epubViewerCubit: context.read<EpubViewerCubit>(),
        ),
      ),
    );
  }

  _showBottomSheet(BuildContext context, EpubViewerCubit cubit) {
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
                StyleSheet(epubViewerCubit: cubit),
              ],
            ),
          ),
        );
      },
    );
  }

  _loadToc(BuildContext context) {
    // BlocProvider.of<EpubCubit>(context).loadToc();
  }

  _toggleBookmark() {
    setState(() {
      isBookmarked = !isBookmarked;
    });
  }

  _determineEpubSourceAndLoad() {
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

  _loadEpubFromBookmark() {
    final int bookmarkPageNumber =
        int.tryParse(widget.referenceModel?.navIndex ?? '') ?? 0;
    // _pageController.jumpToPage(bookmarkPageNumber);
    _bookPath = widget.referenceModel!.bookPath;
    _loadAndParseEpub(bookPath: _bookPath!);
  }

  _loadEpubFromTableOfContents() {
    _bookPath = widget.tocModel!.epubChapter.ContentFileName;
    _loadAndParseEpub(
        bookPath: widget.tocModel!.bookPath, fileName: _bookPath!);
  }

  _loadEpubFromSearchResult() {
    _bookPath = widget.searchModel!.pageId;
    _loadAndParseEpub(
        bookPath: widget.searchModel!.bookAddress!, fileName: _bookPath!);
  }

  _loadEpubFromCategory() {
    _bookPath = widget.catModel!.bookPath!;
    _loadAndParseEpub(bookPath: _bookPath!);
  }

  /// FileName for handling toc and search item to get number of section
  _loadAndParseEpub({required String bookPath, String? fileName}) {
    context.read<EpubViewerCubit>().loadAndParseEpub('$_pathUrl$bookPath');
  }

  @override
  void initState() {
    super.initState();
    _determineEpubSourceAndLoad();
  }

  @override
  dispose() {
    final pageHelper = PageHelper();
    pageHelper.saveBookData(widget.catModel!.bookPath!, _currentPage);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    super.dispose();
  }

  String _getAppBarTitle(EpubViewerState state) {
    return state.maybeWhen(
      loaded: (_, title) => title,
      orElse: () => '',
    );
  }

  _changeStyle(
      FontSizeCustom? fontSize, LineSpace? lineHeight, FontFamily? fontFamily) {
    this.fontFamily = fontFamily ?? FontFamily.font1;
    this.lineHeight = lineHeight ?? LineSpace.normalLineSpace;
    this.fontSize = fontSize ?? FontSizeCustom.normalFontSize;
  }

  _jumpTo({int? pageNumber}) {
    itemScrollController.jumpTo(index: pageNumber ?? 0);
  }

  _storeCurrentPage({int? currentPageNumber}) {
    _currentPage = currentPageNumber?.toDouble() ?? 0.0;
  }
}
