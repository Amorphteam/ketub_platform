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
import 'package:ketub_platform/utils/page_helper.dart';
import 'package:scrollable_positioned_list/scrollable_positioned_list.dart';
import '../main/toc_tab/widgets/toc_tree_list_widget.dart';
import 'internal_search/internal_search_screen.dart';
import 'widgets/style_sheet.dart';

typedef DataCallback = void Function(dynamic data);

class EpubViewerScreen extends StatefulWidget {
  final ReferenceModel? referenceModel;
  final CategoryModel? catModel;
  final EpubChaptersWithBookPath? tocModel;
  final SearchModel? searchModel;

  const EpubViewerScreen({
    Key? key,
    this.referenceModel,
    this.catModel,
    this.tocModel,
    this.searchModel,
  }) : super(key: key);

  @override
  _EpubViewerScreenState createState() => _EpubViewerScreenState();
}

class _EpubViewerScreenState extends State<EpubViewerScreen> {
  int _currentIndex = -1;
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
  List<EpubChapter>? _tocList;
  String? _bookPath;
  FontSizeCustom fontSize = FontSizeCustom.medium;
  LineHeightCustom lineHeight = LineHeightCustom.medium;
  FontFamily fontFamily = FontFamily.font1;
  final String _pathUrl = 'assets/epubs/';
  List<String> _content = [];
  List<String> _orginalContent = [];

  bool _isSliderChange = false;
  String searchedWord = '';
  bool isSearchOpen = false;
  final focusNode = FocusNode();
  final textEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
      listener: (context, state) {
        state.maybeWhen(
          pageChanged: (page) {
            _jumpTo(pageNumber: page);
          },
          contentHighlighted: (_, page) {
            _jumpTo(pageNumber: page);
          },
          searchResultsFound: (searchResults) {
            showSearchResultsDialog(context, searchResults);
          },
          styleChanged: (fontSize, lineSpace, fontFamily){
            print('loadUserPreferences ${lineSpace} add ${fontFamily}');

            _changeStyle(fontSize, lineSpace, fontFamily);
          },
          bookmarkPresent: () => setState(() => isBookmarked = true),
          bookmarkAbsent: () => setState(() => isBookmarked = false),
          orElse: () {},
        );
      },
      builder: (context, state) {
        return Scaffold(
          body: Stack(
            children: [
              if (isSliderVisible)
                AppBar(
                  leading: IconButton(
                    icon: isSearchOpen
                        ? Icon(Icons.close, color: Theme.of(context).colorScheme.onSurfaceVariant)
                        : Icon(Icons.arrow_back, color: Theme.of(context).colorScheme.onSurfaceVariant),
                    onPressed: () {
                      if (isSearchOpen) {
                        _toggleSearch(false);
                      } else {
                        Navigator.of(context).pop();
                      }
                    },
                  ),
                  title: isSearchOpen
                      ? TextField(
                    autofocus: true,
                    focusNode: focusNode,
                    controller: textEditingController,
                    decoration: InputDecoration(
                      hintText: 'أدخل كلمة لبدء البحث ...',
                      border: InputBorder.none,
                      suffixIcon: IconButton(
                        icon: SvgPicture.asset('assets/icons/search.svg', color: Theme.of(context).colorScheme.onSurfaceVariant),
                        // The search icon inside the TextField
                        onPressed: () {
                          // Trigger the search logic, similar to what's done in onSubmitted
                          if (textEditingController.text.isNotEmpty) {
                            final String searchQuery =
                                textEditingController.text;
                            _search(searchQuery);
                          }
                        },
                      ),
                    ),
                    onSubmitted: (value) {
                      _search(value);
                    },
                  )
                      : SizedBox.shrink(),
                  actions: isSearchOpen
                      ? null // No actions when search is open
                      : [
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/search.svg', color: Theme.of(context).colorScheme.onSurfaceVariant),
                      onPressed: () => _toggleSearch(true),
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/style.svg', color: Theme.of(context).colorScheme.onSurfaceVariant),
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
                       color: Theme.of(context).colorScheme.onSurfaceVariant),
                      onPressed: () {
                        _toggleBookmark();
                        if (isBookmarked) {
                          _addBookmark(context);
                        } else {
                          _removeBookmark(context);
                        }
                      },
                    ),
                    IconButton(
                      icon: SvgPicture.asset('assets/icons/toc.svg', color: Theme.of(context).colorScheme.onSurfaceVariant),
                      onPressed: () {
                        _openInternalToc(context);
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
                      loaded: (content, _, tocList) {
                        _storeContentLoaded(content, context, state, tocList);
                        context.read<EpubViewerCubit>().emitLastPageSeen();
                        context.read<EpubViewerCubit>().loadUserPreferences();
                        context.read<EpubViewerCubit>().checkBookmark(_bookPath!, _currentPage.toString());
                        return _buildCurrentUi(context, _content);
                      },
                      contentHighlighted: (content, _) {
                        _orginalContent = _content;
                        _content = content;
                        return _buildCurrentUi(context, content);
                      },
                      bookmarkAbsent: () => _buildCurrentUi(context, _content),
                      bookmarkPresent: () => _buildCurrentUi(context, _content),
                      loading: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      error: (error) {
                        return _buildCurrentUi(context, _content);
                      },
                      initial: () => const Center(
                        child: CircularProgressIndicator(),
                      ),
                      pageChanged: (int? pageNumber) {
                        return _buildCurrentUi(context, _content);
                      },
                      styleChanged: (fontSize,
                          lineHeight,
                          fontFamily) {
                        return _buildCurrentUi(context, _content);
                      },
                      bookmarkAdded: (int? status) {
                        return _buildCurrentUi(context, _content);
                      },
                      searchResultsFound: (List<SearchModel> searchResults) {
                        return _buildCurrentUi(context, _content);
                      }),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  _storeContentLoaded(List<String> htmlContent, BuildContext context,
      EpubViewerState state, List<EpubChapter>? tocList) {
    _content = htmlContent;
    _orginalContent = _content;
    _bookName = _getAppBarTitle(state);
    _tocList = tocList;
  }

  void _toggleSearch(bool open) {
    setState(() {
      isSearchOpen = open;
    });

    if (isSearchOpen) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        FocusScope.of(context).requestFocus(focusNode);
      });
    } else {
      setState(() {
        _content = _orginalContent;
      });
      focusNode.unfocus();
      textEditingController.clear();
    }
  }

  void showSearchResultsDialog(
      BuildContext context, List<SearchModel> searchResults) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('نتائج البحث'),
              Text(searchResults.last.searchCount.toString())
            ],
          ),
          content: Container(
            width: double.maxFinite,
            child: ListView.builder(
              shrinkWrap: true,
              itemCount: searchResults.length,
              itemBuilder: (BuildContext context, int index) {
                final result = searchResults[index];
                return ListTile(
                  title: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: Html(
                            data: result.spanna.toString(),
                            style: {
                              "html": Style(
                                fontSize: FontSize.medium,
                                textAlign: TextAlign.right,
                              ),
                              "mark": Style(
                                backgroundColor: Colors.yellow,
                              ),
                            },
                          )),
                      Text(
                        result.pageIndex.toString(),
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                  onTap: () {
                    this.context.read<EpubViewerCubit>().highlightContent(result.pageIndex, searchedWord);
                    Navigator.of(context)
                        .pop(); // Close the dialog on selection
                  },
                );
              },
            ),
          ),
        );
      },
    );
  }

  Widget _buildCurrentUi(BuildContext context, List<String> content) {
    var allPagesCount = content.length.toDouble();
    return Column(
      children: [
        Expanded(
          child: ScrollablePositionedList.builder(
            itemCount: content.length,
            itemScrollController: itemScrollController,
            scrollOffsetController: scrollOffsetController,
            itemPositionsListener: itemPositionsListener,
            scrollOffsetListener: scrollOffsetListener,
            itemBuilder: (BuildContext context, int index) {
              double screenHeight = MediaQuery.of(context).size.height; // Get screen height

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
                  child: ConstrainedBox(
                    constraints: BoxConstraints(minHeight: screenHeight), // Set minHeight to screenHeight
                    child: Container(
                      color: Theme.of(context).colorScheme.background,
                      child: Html(
                        data: content[index],
                        style: {
                          "html": Style(
                            textAlign: TextAlign.justify,
                            direction: TextDirection.rtl,
                            fontSize: FontSize(fontSize.size),
                            padding: HtmlPaddings.only(right: 10, left: 10),
                            fontFamily: fontFamily.name,
                            lineHeight: LineHeight(lineHeight.size),
                          ),
                          "h1,h2,h3,h4,h5,h6": Style(
                            textAlign: TextAlign.right,
                            direction: TextDirection.rtl,
                            padding: HtmlPaddings.only(top: 30),
                            fontSize: FontSize(fontSize.size * 1.2),
                            fontWeight: FontWeight.bold,
                            fontFamily: fontFamily.name,
                          ),
                          "mark": Style(
                            backgroundColor: Colors.yellow, // Highlight color
                          ),
                        },
                      ),
                    ),
                  ),
                ),
              );
            },
          ),
        ),
        if (isSliderVisible)
          Column(
            children: [
              Slider(
                value: _currentPage,
                min: 0,
                max: allPagesCount - 1,
                onChanged: (newValue) {
                  _isSliderChange = true;
                  setState(() {
                    _currentPage = newValue;
                  });
                },
                onChangeEnd: (newValue) {
                  _jumpTo(pageNumber: newValue.toInt());
                  _isSliderChange = false;
                },
              ),
              Padding(
                padding:
                const EdgeInsets.only(right: 16.0, left: 16.0, bottom: 0.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Flexible(
                      child: Text(
                        _bookName,
                        style: Theme.of(context).textTheme.labelMedium,
                        maxLines: 1,
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        _showPageJumpDialog(context);
                      },
                      child: Text(
                        '${_currentPage.toInt() + 1}/${allPagesCount.toInt()}',
                        style: Theme.of(context).textTheme.labelMedium,
                      ),
                    )

                  ],
                ),
              ),
            ],
          )
      ],
    );
  }

  void _showPageJumpDialog(BuildContext context) {
    final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
    final TextEditingController pageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          content: Form(
            key: _formKey,
            child: TextFormField(
              controller: pageController,
              autofocus: true,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                hintText: "أدخل رقم الصفحة (بين 1 و ${_content.length})",
              ),
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return 'يرجى إدخال رقم الصفحة';
                }
                int? pageNumber = int.tryParse(value);
                if (pageNumber == null || pageNumber <= 0 || pageNumber > _content.length) {
                  return ' الرقم يجب أن يكون بين ١ و ${_content.length}';
                }
                return null;  // Means the input is valid
              },
              onFieldSubmitted: (value) {
                if (_formKey.currentState!.validate()) {
                  int? pageNumber = int.tryParse(value);
                  _jumpTo(pageNumber: pageNumber! - 1);
                  Navigator.of(context).pop();
                }
              },
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('إلغاء'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('انتقل'),
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  int? pageNumber = int.tryParse(pageController.text);
                  _jumpTo(pageNumber: pageNumber! - 1);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }



  void _search(String value) {
    searchedWord = value;
    context.read<EpubViewerCubit>().searchUsingHtmlList(value);
  }

  _openInternalSearch(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => InternalSearchScreen(
          cubit: context.read<EpubViewerCubit>(),
        ),
      ),
    );
  }

  _addBookmark(BuildContext context) {
    final reference = ReferenceModel(
      title: ' علامة مرجعية على كتاب $_bookName',
      bookName: _bookName,
      bookPath: widget.catModel!.bookPath!,
      navIndex: _currentPage.toString(),
    );

    BlocProvider.of<EpubViewerCubit>(context).addBookmark(reference);
    context.read<EpubViewerCubit>().checkBookmark(_bookPath!, _currentPage.toString());

  }

  void _openInternalToc(BuildContext context) {
    // This variable holds the state of the AppBar visibility
    ValueNotifier<bool> showAppBar = ValueNotifier(false);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (BuildContext context) {
        return NotificationListener<DraggableScrollableNotification>(
          onNotification: (notification) {
            // When the sheet is fully expanded, show the AppBar
            showAppBar.value = notification.extent == notification.maxExtent;
            return true; // Return true to cancel the notification bubbling.
          },
          child: DraggableScrollableSheet(
            expand: false,
            initialChildSize: 0.5,
            minChildSize: 0.25,
            maxChildSize: 1.0,
            builder: (BuildContext context, ScrollController scrollController) {
              return Stack(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 56),
                    // Reserve space for the AppBar-like header
                    child: EpubChapterListWidget(
                      tocTreeList: _tocList ?? [],
                      scrollController: scrollController,
                      epubViewerCubit: this.context.read<EpubViewerCubit>(),
                      onClose: () {
                        Future.delayed(const Duration(milliseconds: 300), () {
                          Navigator.pop(context);
                        });
                      },
                    ),
                  ),
                  // Use ValueListenableBuilder to react to changes in showAppBar
                  ValueListenableBuilder<bool>(
                    valueListenable: showAppBar,
                    builder: (context, value, child) {
                      return value
                          ? Positioned(
                        top: 20,
                        left: 0,
                        right: 0,
                        child: SafeArea(
                          child: Container(
                            height: 56,
                            // Standard AppBar height
                            padding: EdgeInsets.symmetric(horizontal: 16),
                            alignment: Alignment.centerRight,
                            color: Colors.transparent,
                            // Adjust the color as needed
                            child: IconButton(
                              icon: Icon(Icons.arrow_back),
                              onPressed: () => Navigator.pop(context),
                            ),
                          ),
                        ),
                      )
                          : SizedBox.shrink(); // If false, don't show anything
                    },
                  ),
                ],
              );
            },
          ),
        );
      },
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
                StyleSheet(epubViewerCubit: cubit, lineSpace: lineHeight, fontFamily: fontFamily, fontSize: fontSize),
              ],
            ),
          ),
        );
      },
    );
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
    itemPositionsListener.itemPositions.addListener(() {
      final positions = itemPositionsListener.itemPositions.value;
      if (positions.isNotEmpty) {
        final int firstVisibleItemIndex = positions
            .where((position) => position.itemLeadingEdge < 1)
            .reduce(
                (max, position) => position.index > max.index ? position : max)
            .index;

        if (_currentIndex != firstVisibleItemIndex) {
          _currentIndex = firstVisibleItemIndex;
          _updateCurrentPage(firstVisibleItemIndex.toDouble());
        }
      }
    });
  }

  void _updateCurrentPage(double newPage) {
    if (_currentPage != newPage) {
      setState(() {
        _currentPage = newPage;
      });
    }
    context.read<EpubViewerCubit>().checkBookmark(_bookPath!, _currentPage.toString());

  }

  @override
  dispose() {
    final pageHelper = PageHelper();
    pageHelper.saveBookData(widget.catModel!.bookPath!, _currentPage);
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);
    itemPositionsListener.itemPositions.removeListener(() {});
    focusNode.dispose();
    textEditingController.dispose();

    super.dispose();
  }

  String _getAppBarTitle(EpubViewerState state) {
    return state.maybeWhen(
      loaded: (_, title, __) => title,
      orElse: () => '',
    );
  }


  _changeStyle(FontSizeCustom? fontSize, LineHeightCustom? lineHeight,
      FontFamily? fontFamily) {
    this.fontFamily = fontFamily ?? FontFamily.font1;
    this.lineHeight = lineHeight ?? LineHeightCustom.medium;
    this.fontSize = fontSize ?? FontSizeCustom.medium;
  }

  _jumpTo({int? pageNumber}) {
    itemScrollController.jumpTo(index: pageNumber ?? 0);
    _currentPage = pageNumber?.toDouble() ?? _currentPage;
    context.read<EpubViewerCubit>().checkBookmark(_bookPath!, _currentPage.toString());

  }

  _storeCurrentPage({int? currentPageNumber}) {
    final newPage = currentPageNumber?.toDouble() ?? 0.0;
    if (_currentPage != newPage) {
      _currentPage = currentPageNumber?.toDouble() ?? 0.0;
    }
  }

  void _removeBookmark(BuildContext context) {
    context.read<EpubViewerCubit>().removeBookmark(_bookPath!, _currentPage.toString());
    context.read<EpubViewerCubit>().checkBookmark(_bookPath!, _currentPage.toString());
  }



}


