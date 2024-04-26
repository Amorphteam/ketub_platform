import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:ketub_platform/screens/main/nav_screen.dart';
import 'package:ketub_platform/screens/splash/splash_screen.dart';
import 'package:ketub_platform/utils/audio_helper.dart';
import 'package:shared_preferences/shared_preferences.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AudioHelper.handleBackgroundAudio();
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.dark,
      systemNavigationBarIconBrightness: Brightness.dark,
    ),
  );
  runApp(const MyApp());
}



class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    const ColorScheme colorScheme = ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xFF4C6707), // Replace with actual color code from the screenshot
      onPrimary: Color(0xFFFFFFFF), // And so on for the rest of the colors
      secondary: Color(0xFF5A6147),
      onSecondary: Color(0xFFFFFFFF),
      error: Color(0xFFBA1A1A),
      onError: Color(0xFFFFFFFF),
      surface: Color(0xFFFBF9F1),
      onSurface: Color(0xFF1B1C17),
      primaryContainer: Color(0xFFCDEF84),
      onPrimaryContainer: Color(0xFF141F00),
      secondaryContainer: Color(0xFFCDEF84),
      onSecondaryContainer: Color(0xFF171E09),
      tertiaryContainer: Color(0xFFBCECE4),
      onTertiaryContainer: Color(0xFF00201D),
      errorContainer: Color(0xFFFFDAD6),
      onErrorContainer: Color(0xFF410002),
      surfaceVariant: Color(0xFFE2E4D4),
      onSurfaceVariant: Color(0xFF45483C),
      outline: Color(0xFF76786B),
      outlineVariant: Color(0xFFC6C8B9),
      background: Color(0xFFFBF9F1),
      onBackground: Color(0xFF1B1C17),
    );
    final ThemeData theme = ThemeData(
      useMaterial3: true,
      colorScheme: colorScheme,
      // Define other theme properties if necessary
      fontFamily: 'tajwal',
    );


    return MaterialApp(
      title: 'Ketub Platform',
      debugShowCheckedModeBanner: false,
      theme: theme,
      home:  FutureBuilder(
        future: isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          } else {
            if (snapshot.data == true) {
              return SplashScreen();
            } else {
              return NavScreen();
            }
          }
        },
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('ar', ''), // Arabic, no country code
        // Add other supported locales here
      ],
      locale: Locale('ar', ''),
    );
  }

  Future<bool> isFirstLaunch() async {
    final prefs = await SharedPreferences.getInstance();
    bool isFirstLaunch = prefs.getBool('first_launch') ?? true;
    if (isFirstLaunch) {
      await prefs.setBool('first_launch', false);
    }
    return isFirstLaunch;
  }
}

