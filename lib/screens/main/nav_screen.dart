import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/screens/main/library_tab/library_tab_screen.dart';
import 'package:ketub_platform/screens/main/no_internet_tab/no_internet_screen.dart';
import 'package:ketub_platform/screens/main/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/repositories/book_database.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/screens/main/toc_tab/toc_screen.dart';

import 'bookmark_tab/bookmark_screen.dart';
import 'bookmark_tab/cubit/bookmark_cubit.dart';
import 'home/home_all_cat_screen.dart';
import 'home/home_tab_screen.dart';
import 'library_tab/cubit/library_cubit.dart';



class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => LibraryCubit(),
      child: homeTabScreen(),
    ),
    BlocProvider(
      create: (context) => LibraryCubit(),
      child: LibraryTabScreen(),
    ),
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
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/books.svg'),
            label: 'الفهرس',
          ),
        ],
      ),
    );
  }
}
