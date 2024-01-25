import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/models/card_type_model.dart';
import 'package:ketub_platform/screens/main/home_tab/widgets/section_card_widget.dart';
import 'package:ketub_platform/utils/home_helper.dart';

import '../../search/search_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<CardTypeModel>? cards;
  @override
  void initState() {
    cards = HomeHelper.cards;
    super.initState();
  }
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
                  contentPadding: const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
                ),
              ),
            ),
          ),
          Expanded(
            child: ListView.builder(
                itemCount: cards?.length,
                itemBuilder: (context, index) {
                  return SectionCardWidget(cardType: cards?[index].cardType ?? CardType.gridLarge, title: cards?[index].title ?? '', hasLoadMore: cards?[index].hasLoadMore ?? false, featureImageUrl: cards?[index].featureImageUrl ?? 'assets/images/bk1.jpg',);
                }),
          ),
        ],
      ),
    );
  }
}
