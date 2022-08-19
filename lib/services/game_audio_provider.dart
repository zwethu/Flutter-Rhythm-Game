import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class GameAudioProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();

  int duration = 0;
  bool pauseGame = false;
  bool isFirstTime = true;
  bool isFinished = false;
  bool songEnd = true;

  void playGameAudio(String input) async {
    if (isFirstTime) {
      if (input.contains('assets')) {
        await player.setAsset(input).then((value) async {
          getDuration(value!);
          await player.play();
          isFirstTime = false;
        });
      } else if (input
          .contains('/data/user/0/com.example.tap_tap_tap/cache/file_picker/')) {
        await player.setFilePath(input).then((value) async {
          getDuration(value!);
          await player.play();
          isFirstTime = false;
        });
      }
    }
  }

  void getDuration(Duration time) {
    int? minutes = time.inMinutes;
    int? seconds = time.inSeconds;
    duration = (minutes * 60) + seconds;
    notifyListeners();
  }

  void pausePlayer() async {
    await player.pause();
  }

  void resumePlayer() async {
    await player.play();
  }

  void changeBool() {
    pauseGame = !pauseGame;
    notifyListeners();
  }

  void replay() {
    isFirstTime = true;
    songEnd = false;
    notifyListeners();
  }
}
