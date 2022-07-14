import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();
  int duration = 0;

  void playAudio(String input) async {
    final time = await player.setAsset(input);
    getDuration(time);
    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void getDuration(Duration? time) {
    int? minutes = time?.inMinutes;
    int? seconds = time?.inSeconds;
    duration = (minutes! * 60) + seconds!;
  }

  void stopPlayer() {
    player.stop();
  }

  void pausePlayer() async {
    player.pause();
  }

  void resumePlayer() async {
    player.play();
  }
}
