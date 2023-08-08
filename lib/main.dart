import 'package:flutter/material.dart';
import 'package:ketub_platform/Screens/nav_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.brown.shade200),
        scaffoldBackgroundColor: Colors.brown.shade50, // Set the background color here
        useMaterial3: true,
      ),
      home:  NavScreen(),
    );
  }
}