// import 'package:flutter/cupertino.dart';
// import 'package:just_audio/just_audio.dart';

// class GameAudioProvider extends ChangeNotifier {
//   AudioPlayer player = AudioPlayer();
//   int duration = 0;
//   bool pauseGame = false;

//   void playGameAudio(String input) async {
//     {
//       if (input.contains('assets')) {
//         await player.setAsset(input).then((value){
//           getDuration(value!);
//         });
//         await player.play();
//       } else if (input
//           .contains('/data/user/0/com.example.tap_tap_tap/cache/filepicker/')) {
//         await player.setFilePath(input).then((value) {
//           getDuration(value!);
//         });
//         await player.play();
//       }
//     }
//   }

//   void getDuration(Duration time) {
//     int? minutes = time.inMinutes;
//     int? seconds = time.inSeconds;
//     duration = (minutes * 60) + seconds;
//     notifyListeners();
//   }

//   void pauseGameAudio() async {
//     await player.pause();
//   }

//   void changeBool() {
//     pauseGame = !pauseGame;
//     notifyListeners();
//   }

//   void resumePlayer() async {
//     await player.play();
//   }
// }
