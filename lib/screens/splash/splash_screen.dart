import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:in_app_update/in_app_update.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:url_launcher/url_launcher.dart';

import '../main/nav_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  AppUpdateInfo? _updateInfo;

  @override
  void initState() {
    super.initState();
    _fetchRemoteConfig();
  }

  Future<void> _fetchRemoteConfig() async {
    final remoteConfig = FirebaseRemoteConfig.instance;

    await remoteConfig.setConfigSettings(RemoteConfigSettings(
      fetchTimeout: const Duration(seconds: 10),
      minimumFetchInterval: const Duration(hours: 1),
    ));

    await remoteConfig.setDefaults(<String, dynamic>{
      'latest_version': '1.0.0',
      'min_supported_version': '1.0.0',
      'update_message': 'A new version is available!',
      'update_required': false,
    });

    try {
      print('Starting fetch for Remote Config...');
      bool updated = await remoteConfig.fetchAndActivate();
      print('Remote Config fetch status: $updated');

      String latestVersion = remoteConfig.getString('latest_version');
      String minSupportedVersion = remoteConfig.getString('min_supported_version');
      String updateMessage = remoteConfig.getString('update_message');
      bool updateRequired = remoteConfig.getBool('update_required');

      if (Platform.isAndroid) {
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        if (compareVersions(currentVersion, minSupportedVersion) < 0) {
          _checkForInAppUpdate(updateMessage, updateRequired);
        } else if (compareVersions(currentVersion, latestVersion) < 0) {
          _checkForInAppUpdate(updateMessage, updateRequired);
        } else {
          _navigateToHome();
        }
      } else if (Platform.isIOS){
        PackageInfo packageInfo = await PackageInfo.fromPlatform();
        String currentVersion = packageInfo.version;

        if (compareVersions(currentVersion, minSupportedVersion) < 0) {
          _showUpdateDialog(updateMessage, updateRequired);
        } else if (compareVersions(currentVersion, latestVersion) < 0) {
          _showUpdateDialog(updateMessage, updateRequired);
        } else {
          _navigateToHome();
        }

      } else
      {
        _navigateToHome();
      }
    } catch (e) {
      print('Remote Config fetch failed: $e');
      _navigateToHome();
    }
  }

  Future<void> _checkForInAppUpdate(String message, bool isRequired) async {
    _updateInfo = await InAppUpdate.checkForUpdate();
    if (_updateInfo?.updateAvailability == UpdateAvailability.updateAvailable) {
      if (isRequired || _updateInfo?.immediateUpdateAllowed == true) {
        InAppUpdate.performImmediateUpdate().catchError((e) {
          // Handle error
        });
      } else {
        _showUpdateDialog(message, isRequired);
      }
    } else {
      _navigateToHome();
    }
  }

  void _showUpdateDialog(String message, bool isRequired) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      showDialog(
        context: context,
        barrierDismissible: !isRequired,
        builder: (context) => AlertDialog(
          title: Row(
            children: [
              Icon(
                Icons.system_update,
                color: Theme.of(context).colorScheme.primary,
              ),
              const SizedBox(width: 10),
              Text(
                'التحديث متاح',
                style: Theme.of(context).textTheme.titleLarge,
              ),
            ],
          ),
          content: Text(
            isRequired
                ? "هذا التحديث ضروري حتى تتمكن من الاستفادة من أحدث الميزات والتحسينات الأمنية في التطبيق."
                : "نسخة جديدة من التطبيق متاحة. سيوفر لك التحديث تجربة أفضل. هل ترغب في التحديث؟",
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          actions: <Widget>[
            if (!isRequired)
              TextButton(
                child: Text(
                  'لاحقًا',
                  style: TextStyle(color: Theme.of(context).colorScheme.secondary),
                ),
                onPressed: () {
                  Navigator.of(context).pop();
                  _navigateToHome();
                },
              ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).colorScheme.primary,
              ),
              child: Text(
                'تحديث',
                style: TextStyle(color: Theme.of(context).colorScheme.onPrimary),
              ),
              onPressed: () {
                if (Platform.isIOS){
                  launch('https://apps.apple.com/us/app/%D8%A7%D9%84%D9%85%D9%88%D9%82%D8%B9-%D8%A7%D9%84%D8%B1%D8%B3%D9%85%D9%8A-%D9%84%D8%AD%D9%8A%D8%AF%D8%B1-%D8%AD%D8%A8-%D8%A7%D9%84%D9%84%D9%87/id1102746215');

                }else{
                  if (_updateInfo?.flexibleUpdateAllowed == true) {
                    InAppUpdate.startFlexibleUpdate().catchError((e) {
                      // Handle error
                    });
                  } else {
                    Navigator.of(context).pop();
                    _navigateToHome();
                  }
                }

              },
            ),
          ],
        ),
      );
    });
  }

  int compareVersions(String v1, String v2) {
    List<int> v1Parts = v1.split('.').map(int.parse).toList();
    List<int> v2Parts = v2.split('.').map(int.parse).toList();

    for (int i = 0; i < v1Parts.length; i++) {
      if (v1Parts[i] > v2Parts[i]) return 1;
      if (v1Parts[i] < v2Parts[i]) return -1;
    }
    return 0;
  }

  void _navigateToHome() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => NavScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: <Widget>[
          Positioned.fill(
            child: SvgPicture.asset(
              'assets/images/bk_large.svg',
              fit: BoxFit.cover,
            ),
          ),
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Container(
              padding: const EdgeInsets.all(20),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Image.asset(
                    height: 100,
                    width: 100,
                    'assets/images/hob.png',
                  ),
                  const SizedBox(height: 40),
                  Center(
                    child: Text(
                      "التطبيق الرسمي لحيدر حب الله",
                      textAlign: TextAlign.center,
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ),
                  const Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Center(
                      child: Text(
                        'يتضمن هذا التطبيق أحدث وأكمل تأليفات ومحاضرات ومقالات الشيخ حيدر حب الله.',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 14),
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Theme.of(context).colorScheme.primary,
                    ),
                    onPressed: _navigateToHome,
                    child: Text(
                      'ابدأ الآن',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Theme.of(context).colorScheme.onPrimary,
                      ),
                    ),
                  ),
                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
