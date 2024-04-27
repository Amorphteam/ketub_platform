import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/screens/main/no_internet_tab/no_internet_screen.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

import '../../epub_viewer/cubit/epub_cubit.dart';
import '../shared_widgets/search_bar_widget.dart';
import 'cubit/bookmark_cubit.dart';
import 'widgets/reference_list_widget.dart';

class BookmarkScreen extends StatefulWidget {
  const BookmarkScreen();

  @override
  State<BookmarkScreen> createState() => _BookmarkScreenState();
}

class _BookmarkScreenState extends State<BookmarkScreen> {
  @override
  void initState() {
    super.initState();
    _loadAllBookmarks();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<BookmarkCubit, BookmarkState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            title: Text('العلامات المرجيعة'),
          ),
          body: _buildBody(state),
        );
      },
    );


  }


  void _loadAllBookmarks() {
    BlocProvider.of<BookmarkCubit>(context).loadAllBookmarks();
  }

  void _filterList(String query) {
    BlocProvider.of<BookmarkCubit>(context).filterBookmarks(query);
  }

  _buildBody(BookmarkState state) {
    if (state is BookmarkLoadingState) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state is AllBookmarksLoadedState) {
      if (state.bookmarks.isEmpty) {
        return Padding(
          padding: const EdgeInsets.only(top: 100.0),
          child: Container(
            height: MediaQuery.of(context).size.height/3,
            padding: EdgeInsets.all(24),
            child: Stack(
              children: [
                Positioned.fill(
                  child: SvgPicture.asset(
                    'assets/images/bk.svg',
                    fit: BoxFit.fill, // This will cover the entire background of the Container
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 40.0, left: 40.0),
                  child: Column(
                    children: [
                      SizedBox(height: 120),
                      Text(
                        'قائمة الإشارات المرجعية فارغة',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'يمكنك إضافة إشارات مرجعية من الكتب التي تقرأها.',
                        style: Theme.of(context).textTheme.labelLarge?.copyWith(
                          color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                        ),

                      ),
                      SizedBox(height: 80),

                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      }
      return _buildList(state);
    } else if (state is BookmarkErrorState) {
      return Center(
        child: Text(state.error.toString()),
      );
    } else {
      return Container();
    }
  }

  Widget _buildList(AllBookmarksLoadedState state) {
    return ReferenceListWidget(referenceList: state.bookmarks);

  }
}
