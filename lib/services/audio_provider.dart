import 'package:flutter/cupertino.dart';
import 'package:just_audio/just_audio.dart';

class AudioProvider extends ChangeNotifier {
  AudioPlayer player = AudioPlayer();

  void playAudio(String input) async {
    await player.setAsset(input);

    player.setLoopMode(LoopMode.one);
    player.play();
  }

  void resumePlayer() async {
    await player.play();
  }

  void pausePlayer() async {
    await player.pause();
  }
}
