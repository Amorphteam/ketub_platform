import 'package:flutter/material.dart';
import 'package:ketub_platform/pages/library_page.dart';
import 'package:ketub_platform/pages/toc_page.dart';
import 'package:ketub_platform/util/temp_data.dart';

class NavPage extends StatefulWidget {
  @override
  _NavPageState createState() => _NavPageState();
}

class _NavPageState extends State<NavPage> {
  int _currentIndex = 0;

  final List<Widget> _pages = [
    LibraryPage(),
    TocPage(indexItems),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My App'),
      ),
      body: _pages[_currentIndex],
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
        ],
      ),
    );
  }
}
