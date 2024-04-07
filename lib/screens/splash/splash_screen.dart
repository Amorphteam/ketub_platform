import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../../utils/common.dart';
import '../main/nav_screen.dart';

class SplashScreen extends StatefulWidget {
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Future.delayed(Duration(seconds: 2), () {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => NavScreen()),
        );
      });
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Align(
            alignment: Alignment.bottomLeft,
            child: Image.asset(
              'assets/images/nosos_logo_bk.png',
              width: 100,
            ),
          ),
          // Align your text in the center or wherever it needs to be
          Positioned(
            bottom: 100,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                buildLogoAndTitle(context, 'assets/images/ejtihad_logo.png', 'الاجتهاد والتجديد', 'فصلية متخصصة بقضايا الاجتهاد والتجديد الإسلامي'),
                SizedBox(height: 40,),
                buildLogoAndTitle(context, 'assets/images/nosos_logo.png', 'نصوص معاصرة', 'فصلية تعني بالفكر الديني المعاصر'),

              ],
            ),
          )],
      ),

    );
  }

}
