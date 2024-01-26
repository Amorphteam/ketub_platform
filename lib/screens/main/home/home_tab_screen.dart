import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import this if you are using SVG images
import 'package:ketub_platform/screens/main/home/home_tree_cat_screen.dart';
import 'package:ketub_platform/screens/main/shared_widgets/search_bar_widget.dart';

import '../../../models/card_type_model.dart';
import '../../../utils/home_helper.dart';
import '../../search/search_screen.dart';
import 'home_all_cat_screen.dart';
import 'home_recent_content_screen.dart';

class homeTabScreen extends StatefulWidget {
  const homeTabScreen({super.key});

  @override
  State<homeTabScreen> createState() => _homeTabScreenState();
}

class _homeTabScreenState extends State<homeTabScreen> with SingleTickerProviderStateMixin {
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
            Expanded(child: SearchBarWiget()),
            PopupMenuButton<String>(
              onSelected: (String result) {
                // Handle the menu item action here
                switch (result) {
                  case 'option1':
                  // Do something for option 1
                    break;
                  case 'option2':
                  // Do something for option 2
                    break;
                // Add more cases for each menu option
                }
              },
              itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                const PopupMenuItem<String>(
                  value: 'option1',
                  child: Text('السيرة الذاتية'),
                ),
                const PopupMenuItem<String>(
                  value: 'option2',
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
    return homeAllCatScreen();
  }

  Widget _buildRecentContent() {
    return homeRecentContentScreen();
  }

  Widget _buildTreeContent() {
    return HomeTreeCatScreen();
  }

}
