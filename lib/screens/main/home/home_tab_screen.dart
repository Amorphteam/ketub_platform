import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart'; // Import this if you are using SVG images
import 'package:ketub_platform/screens/main/home/home_tree_cat_screen.dart';

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
        title: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => SearchScreen(allCats: []),
                ),
              );
            },
            child: TextField(
              decoration: InputDecoration(
                filled: true,
                fillColor: Colors.grey[200], // Adjust the color to match your UI design
                hintText: 'أدخل كلمة لبدء البحث', hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]), // Your hint text in Arabic
                prefixIcon: IconButton(
                  icon: SvgPicture.asset(
                    'assets/icons/search.svg',
                    color: Colors.grey[600], // Adjust the color as needed
                    width: 20, // Adjust the size as needed
                    height: 20, // Adjust the size as needed
                  ),
                  onPressed: () {
                    // Add the search logic here if necessary
                  },
                ),
                suffixIcon: IconButton(
                  icon: Icon(Icons.mic, color: Colors.grey), // Use your SVG asset if needed
                  onPressed: () {
                    // Implement your voice search logic
                  },
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                  borderSide: BorderSide.none, // No border
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
              ),
            ),
          ),
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
