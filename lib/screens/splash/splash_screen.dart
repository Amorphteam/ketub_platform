import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../main/nav_screen.dart';

class SplashScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          // Full screen background SVG
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/bk_large.svg', // Replace with your SVG file path
              fit: BoxFit.cover,
            ),
          ),
          // Content at the bottom
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: EdgeInsets.all(20),
              decoration: BoxDecoration(
                  // Add decoration if needed
                  ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    height: 100,
                    width: 100,
                    'assets/images/hob.png', // Replace with your image file path
                    // Set size as needed
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: Text(
                      textAlign: TextAlign.center,
                      "التطبيق الرسمي لحيدر حب الله",
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        textAlign: TextAlign.center,
                        'يتضمن هذا التطبيق أحدث وأكمل تأليفات ومحاضرات ومقالات الشيخ حيدر حب الله.',
                        style: Theme.of(context).textTheme.labelLarge,
                      ),
                    ),
                  ),
                  SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),

                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => NavScreen(),
                        ),
                      );                    },
                    child: Text('ابدأ الآن', style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Theme.of(context).colorScheme.onPrimary)),
                  ),
                  SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
