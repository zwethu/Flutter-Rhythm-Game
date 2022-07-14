import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class GameAudioProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  int? time;
  int minutes = 0;
  int seconds = 0;

  void playAudio(String input) async {
    final duration = await player.setAsset(input);
    getDuration(duration);
  }

  void getDuration(Duration? duration) {
    time = duration?.inSeconds;
    minutes = (time! / 60).floor();
    seconds = (time! % 60);
  }

  void stopPlayer() {
    player.stop();
  }

  void pausePlayer() {
    player.pause();
  }

  void resumePlayer() {
    player.play();
  }
}
