import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/screens/main/library_tab/library_all_books_screen.dart';
import 'package:ketub_platform/screens/main/library_tab/library_tab_screen.dart';
import 'package:ketub_platform/screens/main/no_internet_tab/no_internet_screen.dart';
import 'package:ketub_platform/screens/main/toc_tab/cubit/toc_cubit.dart';
import 'package:ketub_platform/repositories/book_database.dart';
import 'package:ketub_platform/repositories/reference_database.dart';
import 'package:ketub_platform/screens/main/toc_tab/toc_screen.dart';

import 'about/about_app_screen.dart';
import 'bookmark_tab/bookmark_screen.dart';
import 'bookmark_tab/cubit/bookmark_cubit.dart';
import 'home/home_all_cat_screen.dart';
import 'home/home_tab_screen.dart';
import 'library_tab/cubit/library_all_books_cubit.dart';



class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;

  final List<Widget> _pages = [

    BlocProvider(
      create: (context) => LibraryAllBooksCubit(),
      child: LibraryAllBooksScreen(),
    ),
    BlocProvider(
      create: (context) => BookmarkCubit(),
      child: BookmarkScreen(),
    ),
    BlocProvider(
      create: (context) => BookmarkCubit(),
      child: AboutAppScreen(),
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
            label: 'الكتب والمؤلفات',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/bookmark.svg'),
            label: 'المفضلة',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/info.svg'),
            label: 'حول التطبيق',
          ),
        ],
      ),
    );
  }
}
