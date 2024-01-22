import 'package:epub_parser/epub_parser.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:ketub_platform/models/category_model.dart';
import 'package:ketub_platform/models/reference_model.dart';
import 'package:ketub_platform/models/search_model.dart';
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

class EpubScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final CategoryModel? catModel;
  final EpubChaptersWithBookPath? tocModel;
  final SearchModel? searchModel;
  final DataCallback? onDataReceived;

  const EpubScreen({
    Key? key,
    this.referenceModel,
    this.catModel,
    this.tocModel,
    this.onDataReceived,
    this.searchModel,
  }) : super(key: key);

  @override
  _EpubScreenState createState() => _EpubScreenState();
}

class _EpubScreenState extends State<EpubScreen> {
  final ItemScrollController itemScrollController = ItemScrollController();
  final ScrollOffsetController scrollOffsetController =
  ScrollOffsetController();
  final ItemPositionsListener itemPositionsListener =
  ItemPositionsListener.create();
  final ScrollOffsetListener scrollOffsetListener =
  ScrollOffsetListener.create();
  String _bookName = '';
  PageHelper pageHelper = PageHelper();
  double currentPage = 0;
  bool isSliderVisible = true;
  bool isBookmarked = false;
  EpubChapter? _chapter;
  List<EpubChapter>? tocList;
  String? _bookPath;
  final String _pathUrl = 'assets/epubs/';


  @override
  Widget build(BuildContext context) {
    _loadToc(context);
    if (_chapter != null) {
      context.read<EpubViewerCubit>().jumpToPage(
          chapterFileName: _chapter!.ContentFileName);
    }
    if (!isSliderVisible) {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
    } else {
      SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
          overlays: SystemUiOverlay.values);
    }

    return BlocConsumer<EpubViewerCubit, EpubViewerState>(
      listener: (context, state) {

      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (isSliderVisible)
                AppBar(
                  title: Text(_getAppBarTitle(state)),
                  actions: [
                    IconButton(
                      icon: const Icon(Icons.search),
                      onPressed: () {
                        _openInternalSearch(context);
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.tune_rounded),
                      onPressed: () {
                        _showBottomSheet(
                            context, context.read<EpubViewerCubit>());
                      },
                    ),
                    IconButton(
                      icon: Icon(
                        isBookmarked ? Icons.bookmark : Icons.bookmark_border,
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
                      icon: const Icon(Icons.description_outlined),
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
                          MediaQuery
                              .of(context)
                              .padding
                              .top), // Adjust top margin based on visibility
                  child: state.maybeWhen(loaded: (content, _) => _buildContentLoaded(content, context), orElse: () => const CircularProgressIndicator())


                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildContentLoaded(List<String> content, BuildContext context) {
    var allPagesCount = content.length.toDouble();
    return Row(
      children: [
        Expanded(
          child: Column(
            children: [
              Expanded(
                child: ScrollablePositionedList.builder(
                    itemCount: content.length,
                    itemScrollController: itemScrollController,
                    scrollOffsetController:
                    scrollOffsetController,
                    itemPositionsListener:
                    itemPositionsListener,
                    scrollOffsetListener: scrollOffsetListener,
                    itemBuilder:
                        (BuildContext context, int index) {
                      // return Text(state.content[index]);
                      return Padding(
                        padding: const EdgeInsets.only(
                            top: 20.0),
                        child: Container(
                          color: Colors.white,
                          child: SingleChildScrollView(
                            child: Html(
                              data: content[index],
                              style: {
                                "html": Style(
                                    textAlign:
                                    TextAlign.justify,
                                    direction:
                                    TextDirection.rtl,
                                    fontSize: FontSize
                                        .large,
                                    fontFamily: 'font1'),
                                "h1,h2,h3": Style(
                                    textAlign:
                                    TextAlign.justify,
                                    direction:
                                    TextDirection.rtl,
                                    padding: HtmlPaddings
                                        .only(
                                        top: 30),
                                    fontSize: FontSize
                                        .xLarge,
                                    fontWeight: FontWeight
                                        .bold,
                                    fontFamily: 'font3'),
                              },
                            ),
                          ),
                        ),
                      );
                      ;
                    }),
              ),
              if (isSliderVisible)
                Row(
                  mainAxisAlignment:
                  MainAxisAlignment.spaceBetween,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Text(
                          '${currentPage
                              .toInt()}/${allPagesCount
                              .toInt()}'),
                    ),
                    Expanded(
                      child: VerticalSeekBar(
                        currentPage: currentPage,
                        allPagesCount: allPagesCount,
                        epubViewerCubit:
                        context.read<EpubViewerCubit>(),
                        bookPath: _bookPath!,
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
        builder: (context) =>
            InternalSearchScreen(
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
      navIndex: currentPage.toString(),
    );

    // BlocProvider.of<EpubCubit>(context)
    //     .addBookmark(reference);
  }

  _openIternalToc(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) =>
            InternalToc(
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
        double maxContentHeight = MediaQuery
            .of(context)
            .size
            .height * 0.8;

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
    context.read<EpubViewerCubit>()
        .loadAndParseEpub('$_pathUrl$bookPath');
  }

  @override
  void initState() {
    super.initState();
    _determineEpubSourceAndLoad();
  }


  @override
  dispose() {
    final pageHelper = PageHelper();
    pageHelper.saveBookData(widget.catModel!.bookPath!, currentPage);
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

}

