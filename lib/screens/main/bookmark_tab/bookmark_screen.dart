import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
