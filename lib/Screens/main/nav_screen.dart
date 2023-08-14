import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/repositories/book_database.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/screens/bookmark_tab/bookmark_screen.dart';
import 'package:ketub_platform/screens/bookmark_tab/cubit/bookmark_cubit.dart';
import 'package:ketub_platform/screens/library_tab/cubit/library_cubit.dart';
import 'package:ketub_platform/screens/library_tab/library_screen.dart';
import 'package:ketub_platform/screens/toc_tab/toc_screen.dart';
import 'package:ketub_platform/utils/temp_data.dart';




class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => LibraryCubit(BookDatabase.instance),
      child: const LibraryScreen(),
    ),
    TocScreen(tempToc),
    BlocProvider(
      create: (context) => BookmarkCubit(ReferenceDatabase.instance),
      child: const BookmarkScreen(),
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: _pages[_currentIndex],
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: _currentIndex,
        onDestinationSelected: (index) {
          setState(() {
            _currentIndex = index;
          });
        },
        destinations: const [
          NavigationDestination(
            icon: Icon(Icons.home),
            label: 'home',
          ),
          NavigationDestination(
            icon: Icon(Icons.toc),
            label: 'toc',
          ),
          NavigationDestination(
            icon: Icon(Icons.bookmark),
            label: 'bookmark',
          ),
        ],
      ),
    );
  }
}
