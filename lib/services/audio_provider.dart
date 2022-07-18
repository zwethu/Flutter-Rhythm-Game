import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  int duration = 0;
  bool pauseGame = false;
  bool isFirstTime = true;

  void playAudio(String input) async {
    final time = await player.setAsset(input);
    getDuration(time);
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void playGameAudio(String input) async {
    if (isFirstTime) {
      if (input.contains('assets')) {
        await player.setAsset(input).then((value) => getDuration(value));

        await player.play();
      } else if (input
          .contains('/data/user/0/com.example.tap_tap_tap/cache/filepicker/')) {
        await player.setFilePath(input).then((value) => getDuration(value));
        await player.play();
      }
    }
  }

  void getDuration(Duration? time) {
    int? minutes = time?.inMinutes;
    int? seconds = time?.inSeconds;
    duration = (minutes! * 60) + seconds!;
  }

  void stopPlayer() async {
    await player.stop();
  }

  void pausePlayer() async {
    pauseGame = false;
    notifyListeners();
    await player.pause();
  }

  void resumePlayer() async {
    pauseGame = true;

    notifyListeners();
    await player.play();
  }

  void pauseGameAudio() async {
    isFirstTime = false;
    notifyListeners();
    await player.pause();
  }

  void changeBool() {
    pauseGame = !pauseGame;
    notifyListeners();
  }
}
