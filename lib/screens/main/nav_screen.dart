import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/main/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/screens/main/toc_tab/toc_screen.dart';

import 'bookmark_tab/bookmark_screen.dart';
import 'bookmark_tab/cubit/bookmark_cubit.dart';
import 'library_tab/cubit/library_cubit.dart';
import 'library_tab/library_screen.dart';



class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => LibraryCubit(),
      child: const LibraryScreen(),
    ),
    BlocProvider(
      create: (context) => TocCubit(),
      child: const TocScreen(),
    ),
    BlocProvider(
      create: (context) => BookmarkCubit(),
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
