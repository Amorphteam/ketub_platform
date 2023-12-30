import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ketub_platform/screens/audio_screen/audio_screen.dart';
import 'package:ketub_platform/screens/audio_screen/cubit/audio_cubit.dart';
import 'package:ketub_platform/screens/bookmark_tab/bookmark_screen.dart';
import 'package:ketub_platform/screens/bookmark_tab/cubit/bookmark_cubit.dart';
import 'package:ketub_platform/screens/library_tab/cubit/library_cubit.dart';
import 'package:ketub_platform/screens/library_tab/library_screen.dart';
import 'package:ketub_platform/screens/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/screens/toc_tab/toc_screen.dart';


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
    ),
    BlocProvider(
      create: (context) => AudioCubit(),
      child: const AudioScreen(),
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
          NavigationDestination(
            icon: Icon(Icons.play_arrow),
            label: 'audio',
          ),
        ],
      ),
    );
  }
}
