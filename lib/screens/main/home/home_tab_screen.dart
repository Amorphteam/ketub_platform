import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import this if you are using SVG images
import 'package:ketub_platform/screens/html_viewer/cubit/html_viewer_cubit.dart';
import 'package:ketub_platform/screens/html_viewer/html_viewer_screen.dart';
import 'package:ketub_platform/screens/main/about/about_app_screen.dart';
import 'package:ketub_platform/screens/main/home/cubit/home_all_cat_cubit.dart';
import 'package:ketub_platform/screens/main/home/cubit/search_online_cubit.dart';
import 'package:ketub_platform/screens/main/home/home_tree_cat_screen.dart';
import 'package:ketub_platform/screens/main/shared_widgets/search_bar_widget.dart';

import 'home_all_cat_screen.dart';
import 'search_online_screen.dart';

class homeTabScreen extends StatefulWidget {
  const homeTabScreen({super.key});

  @override
  State<homeTabScreen> createState() => _homeTabScreenState();
}

class _homeTabScreenState extends State<homeTabScreen>
    with SingleTickerProviderStateMixin {
  TabController? _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
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
            Expanded(
                child: SearchBarWiget(hint: 'ابحث في كل المحتوى',
              onClicked: startOnlineSearch,
            )),
            PopupMenuButton<String>(
              onSelected: (String result) {
                // Handle the menu item action here
                switch (result) {
                  case 'cv':
                    _openCvScreen();
                    break;
                  case 'about':
                    _openAboutAppScreen();

                    break;
                  // Add more cases for each menu option
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'cv',
                  child: Text('السيرة الذاتية'),
                ),
                const PopupMenuItem<String>(
                  value: 'about',
                  child: Text('حول التطبيق'),
                ),
                // Add more PopupMenuItem widgets for each menu option
              ],
              icon: const Icon(Icons.more_vert_rounded),
            ),
          ],
        ),
        bottom: TabBar(
          controller: _tabController,
          tabs: [
            Tab(text: 'الجميع'),
            // Tab(text: 'الأحدث'),
            Tab(text: 'حسب التصنيف'),
          ],
        ),
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildTabContent(),
          // _buildRecentContent(),
          _buildTreeContent(),
        ],
      ),
    );
  }

  Widget _buildTabContent() {
    return BlocProvider<HomeAllCatCubit>(
      create: (context) => HomeAllCatCubit(),
      child: homeAllCatScreen(),
    );
  }


  Widget _buildTreeContent() {
    return HomeTreeCatScreen();
  }

  _openCvScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
            create: (context) => HtmlViewerCubit(),
            child: HtmlViewerScreen(
              id: 49482,
            )),
      ),
    );
  }

  void startOnlineSearch(String p1) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider(
          create: (context) => SearchOnlineCubit(),
          child: SearchOnlineScreen(query: p1),
        ),
      ),
    );
  }

  void _openAboutAppScreen() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AboutAppScreen(),
      ),
    );
  }
}
