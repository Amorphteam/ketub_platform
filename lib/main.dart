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
    return MaterialApp(
      title: 'Ketub Platform',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true, // Enable Material 3
        fontFamily: 'tajwal', // Set the font family
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        fontFamily: 'tajwal',
        brightness: Brightness.dark,
        // Directly define the color scheme
        colorScheme: ColorScheme.dark(
          primary: Color(0xFFA48344), // A gold-like color.
          onPrimary: Colors.white, // White color for text/icons on top of the primary color.
          secondary: Color(0xFFA48344), // A softer gold-like color for secondary elements.
          onSecondary: Colors.grey, // White color for text/icons on top of the secondary color.
          surface: Color(0xFF1F1F1F), // A color for card backgrounds and surfaces.
          onSurface: Colors.white, // White color for text/icons on top of the surface color.
          background: Color(0xFF121212), // A dark color for the app's background.
          onBackground: Colors.white, // White color for text/icons on top of the background color.
          error: Color(0xFFCF6679), // The Material default error color in dark theme.
          onError: Colors.white, // Color for text/icons on top of the error color.
        ),
      ),
      themeMode: ThemeMode.dark, // Always use the dark theme
      home: FutureBuilder<bool>(
        future: isFirstLaunch(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            // Wrap CircularProgressIndicator in a Center widget
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == true) {
            return SplashScreen();
          } else {
            return NavScreen();
          }
        },
      ),
      localizationsDelegates: const [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: const [
        Locale('ar', ''), // Arabic, no country code
        // Add other supported locales here
      ],
      locale: const Locale('ar', ''),
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

