import 'package:flutter/material.dart';
import 'package:ketub_platform/screens/main/nav_screen.dart';

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
        fontFamily: 'tajwal',
        useMaterial3: true,
      ),
      home:  NavScreen(),
    );
  }
}

