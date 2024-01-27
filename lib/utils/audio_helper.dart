import 'package:just_audio_background/just_audio_background.dart';

class AudioHelper{
  static Future<void> handleBackgroundAudio() async {
    await JustAudioBackground.init(
      androidNotificationChannelId: 'com.ryanheise.bg_demo.channel.audio',
      androidNotificationChannelName: 'Audio playback',
      androidNotificationOngoing: true,
    );
  }
}