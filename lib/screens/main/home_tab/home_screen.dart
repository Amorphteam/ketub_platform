import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/screens/main/home_tab/widgets/section_card_widget.dart';

import '../../search/search_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
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
                  contentPadding: EdgeInsets.symmetric(vertical: 0, horizontal: 20), // Adjust padding
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: 6,
                itemBuilder: (context, index) {
                  return const SectionCardWidget();
                }),
          ),
        ],
      ),
    );
  }
}
