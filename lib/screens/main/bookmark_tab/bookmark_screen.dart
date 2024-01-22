import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/utils/epub_helper.dart';

import '../../epub_viewer/cubit/epub_cubit.dart';
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
    return Column(
      children: [
        Container(
          padding: EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: TextField(
            onChanged: (value) => _filterList(value),
            // Assuming _filterList is defined somewhere
            decoration: InputDecoration(
              contentPadding: EdgeInsets.zero,
              labelText: 'Search',
              prefixIcon: Icon(Icons.search),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10),
              ),
            ),
          ),
        ),
        BlocConsumer<BookmarkCubit, BookmarkState>(
          listener: (context, state) {
            if (state is BookmarkErrorState) {
              ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(content: Text(state.error.toString())));
            } else if (state is BookmarkTappedState) {
              openEpub(context: context, reference: state.item);
            }
          },
          builder: (context, state) {
            if (state is AllBookmarksLoadedState) {
              return Flexible(
                child: ReferenceListWidget(referenceList: state.bookmarks),
              );
            } else if (state is BookmarkLoadingState) {
              return CircularProgressIndicator();
            } else {
              return const SizedBox.shrink();
            }
          },
          buildWhen: (previousState, state) {
            return state is AllBookmarksLoadedState ||
                state is BookmarkLoadingState;
          },
        )
      ],
    );
  }

  void _loadAllBookmarks() {
    BlocProvider.of<BookmarkCubit>(context).loadAllBookmarks();
  }

  void _filterList(String query) {
    BlocProvider.of<BookmarkCubit>(context).filterBookmarks(query);
  }
}
