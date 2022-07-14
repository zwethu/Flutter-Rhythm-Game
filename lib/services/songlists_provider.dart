import 'package:flutter/cupertino.dart';
import 'package:hive_flutter/hive_flutter.dart';

class SonglistsProvider extends ChangeNotifier {
  Box? box;
  List<String>? pathsList = [
    'assets/audio/without_u.m4a',
    'assets/audio/clarity.m4a',
    'assets/audio/kimi_no_sei.m4a',
    'assets/audio/lullaby.m4a',
    'assets/audio/one_kiss.m4a',
    'assets/audio/racing_into_the_night.mp3',
    'assets/audio/sunflower.mp3',
  ];
  List<String>? songs = [];

  void openHive() async {
    box = Hive.box('songBox');
  }

  void getPaths() {
    var data = box?.get('songs');
    if (data != null) {
      pathsList = data;
    }
  }


  void addSong(String input) {
    songs?.add(input);
    notifyListeners();
    box?.put('songs', songs);
  }

  void deleteSong(int index) {
    songs?.removeAt(index);
    notifyListeners();
    box?.put('songs', songs);
  }

  void deleteAll() {
    box?.delete('songs');
  }

  void getSongs(){
    List<String>? tempPaths = [];
    for(int i = 0 ; i< pathsList!.length; i++){
      List<String>? path = pathsList![i].split('/');
      tempPaths.add(path.last);
    }
    for(int i = 0 ; i < tempPaths.length ; i++){
      List<String>? name = tempPaths[i].split('.');
      songs?.add(name.first);
    }
  }
}
