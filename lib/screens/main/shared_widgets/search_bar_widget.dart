import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:ketub_platform/screens/main/bookmark_tab/cubit/bookmark_cubit.dart';

import '../../audio/audio_screen.dart';
import '../../audio/cubit/audio_player_cubit.dart';
import '../../search/search_screen.dart';

class SearchBarWiget extends StatefulWidget {
  final BookmarkCubit? bookamrkCubit;

  const SearchBarWiget({super.key, this.bookamrkCubit});

  @override
  State<SearchBarWiget> createState() => _SearchBarWigetState();
}

class _SearchBarWigetState extends State<SearchBarWiget> {
  final TextEditingController _searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Container(
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
          controller: _searchController,
          decoration: InputDecoration(
            filled: true,
            fillColor: Colors.grey[200],
            // Adjust the color to match your UI design
            hintText: 'أدخل كلمة لبدء البحث',
            hintStyle: TextStyle(fontSize: 12, color: Colors.grey[500]),
            // Your hint text in Arabic
            prefixIcon: IconButton(
              icon: SvgPicture.asset(
                'assets/icons/search.svg',
                color: Colors.grey[600], // Adjust the color as needed
                width: 20, // Adjust the size as needed
                height: 20, // Adjust the size as needed
              ),
              onPressed: () {},
            ),
            suffixIcon: IconButton(
              icon: Icon(Icons.mic, color: Colors.grey),
              // Use your SVG asset if needed
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        BlocProvider(
                          create: (context) => AudioPlayerCubit(),
                          child: AudioScreen(),
                        ),
                  ),
                );
              },
            ),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(30.0),
              borderSide: BorderSide.none, // No border
            ),
            contentPadding:
                const EdgeInsets.symmetric(vertical: 0, horizontal: 20),
          ),
          onChanged: (value) {
              if (widget.bookamrkCubit != null) {
                widget.bookamrkCubit!.filterBookmarks(value);

            }
          },
        ),
      ),
    );
  }
}
