import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/screens/main/bookmark_tab/bookmark_screen.dart';
import 'package:ketub_platform/screens/main/bookmark_tab/cubit/bookmark_cubit.dart';
import 'package:ketub_platform/screens/main/library_tab/cubit/library_all_books_cubit.dart';
import 'package:ketub_platform/screens/main/library_tab/library_all_books_screen.dart';
import 'package:ketub_platform/screens/main/shared_widgets/search_bar_widget.dart';

import '../../search/search_screen.dart';

class LibraryTabScreen extends StatefulWidget {
  const LibraryTabScreen({super.key});

  @override
  State<LibraryTabScreen> createState() => _LibraryTabScreenState();
}

class _LibraryTabScreenState extends State<LibraryTabScreen> with SingleTickerProviderStateMixin  {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  void dispose() {
    _tabController?.dispose();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            const Expanded(child: SearchBarWiget()),
            Stack(
              alignment: Alignment.center,
              children: [
                IconButton(
                  onPressed: () {
                    _openBookmarkScreen();
                  },
                  icon: SvgPicture.asset('assets/icons/bookmark.svg', color: Theme.of(context).colorScheme.onSurfaceVariant),
                ),
                Positioned(
                  // Position the badge on the top right corner of the IconButton
                  top: 4,
                  right: 4,
                  child: Container(
                    padding: EdgeInsets.only(top: 3), // The padding inside the badge
                    decoration: BoxDecoration(
                      color: Colors.red, // Background color of the badge
                      borderRadius: BorderRadius.circular(20), // Border radius of the badge
                    ),
                    constraints: const BoxConstraints(
                      minWidth: 18, // Minimum width of the badge
                      minHeight: 18, // Minimum height of the badge
                    ),
                    child: const Center(
                      child: Text(
                        '12', // The number inside the badge
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: Colors.white, // Text color inside the badge
                          fontSize: 10, // Font size for the number inside the badge
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            )

          ],
        ),

        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'الجميع'),
            Tab(text: 'الأحدث'),
            Tab(text: 'حسب التصنيف'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(),
          _buildRecentContent(),
          _buildTreeContent(),
        ],
      ),
    );
  }

  
  
  Widget _buildTabContent() {
    return BlocProvider(
  create: (context) => LibraryAllBooksCubit(),
  child: const LibraryAllBooksScreen(),
);
  }

  Widget _buildRecentContent() {
    return LibraryAllBooksScreen();
  }

  Widget _buildTreeContent() {
    return LibraryAllBooksScreen();
  }


 _openBookmarkScreen (){
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => BookmarkCubit(),
          child: BookmarkScreen(),
        ),
      ),
    );
  }
}