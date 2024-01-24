import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/screens/main/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/repositories/book_database.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/screens/main/toc_tab/toc_screen.dart';

import 'bookmark_tab/bookmark_screen.dart';
import 'bookmark_tab/cubit/bookmark_cubit.dart';
import 'library_tab/cubit/library_cubit.dart';
import 'library_tab/library_screen.dart';

import '../audio/audio_screen.dart';
import '../audio/cubit/audio_cubit.dart';


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
        destinations: [
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/home.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/books.svg'),
            label: '',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/toc.svg'),
            label: ' '
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
