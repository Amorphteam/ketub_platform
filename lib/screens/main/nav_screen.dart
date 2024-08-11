import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:ketub_platform/screens/main/library_tab/library_all_books_screen.dart';


import '../../repositories/sync_service.dart';

import 'home/home_tab_screen.dart';
import 'library_tab/cubit/library_all_books_cubit.dart';



class NavScreen extends StatefulWidget {
  @override
  _NavScreenState createState() => _NavScreenState();
}

class _NavScreenState extends State<NavScreen> {
  int _currentIndex = 0;
  final SyncService syncService = SyncService();

  final List<Widget> _pages = [
    BlocProvider(
      create: (context) => LibraryAllBooksCubit(),
      child: homeTabScreen(),
    ),
    BlocProvider(
      create: (context) => LibraryAllBooksCubit(),
      child: LibraryAllBooksScreen(),
    ),
  ];


  @override
  void initState() {
    super.initState();
    syncDataInBackground();
  }

  Future<void> syncDataInBackground() async {
    await syncService.syncOfflineAndOnlineData();
  }

  Future<void> syncOfflineDataWithFirestore() async {
    await syncService.syncOfflineDataWithFirestore();
  }

  @override
  void dispose() {
    syncOfflineDataWithFirestore;
    super.dispose();
  }


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
            icon: SvgPicture.asset('assets/icons/home.svg', color: Theme.of(context).colorScheme.onSurfaceVariant,),
            label: 'الرئيسية',
          ),
          NavigationDestination(
            icon: SvgPicture.asset('assets/icons/books.svg', color: Theme.of(context).colorScheme.onSurfaceVariant,),
            label: 'الكتب والمؤلفات',
          ),
        ],
      ),
    );
  }
}
