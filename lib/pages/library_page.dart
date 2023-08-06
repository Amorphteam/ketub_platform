import 'package:flutter/material.dart';
import 'package:ketub_platform/util/temp_data.dart';

class LibraryPage extends StatelessWidget {



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: GridView.builder(
        gridDelegate:  SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3, // Number of columns
          crossAxisSpacing: 10, // Spacing between columns
          mainAxisSpacing: 10,
          childAspectRatio: 0.9,// Spacing between rows
        ),
        itemCount: bookItems.length,
        itemBuilder: (context, index) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10), // Rounded corners
                    image: DecorationImage(
                      image: AssetImage('assets/images/' + bookItems[index].imagePath),
                      fit: BoxFit.contain,
                    ),
                  ),
                ),
              ),
              SizedBox(height: 5), // Add spacing between image and title
              Text(
                bookItems[index].title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}