import 'package:flutter/material.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ketub_platform/screens/main/nav_screen.dart';
import 'package:ketub_platform/utils/audio_manager.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await JustAudioBackground.init(
    androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
    androidNotificationChannelName: 'Audio playback',
    androidNotificationOngoing: true,
  );
  await AudioManager.init();
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

