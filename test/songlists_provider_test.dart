import 'package:flutter_test/flutter_test.dart';
import 'package:tap_tap_tap/services/songlists_provider.dart';

void main() {
  SonglistsProvider provider = SonglistsProvider();
  String tInput = 'abc';
  List<String>? songs = [
    'without_u',
    'clarity',
    'kimi_no_sei',
    'lullaby',
    'one_kiss',
    'racing_into_the_night',
    'sunflower',
  ];
  List<String>? pathsList = [
    'assets/audio/without_u.m4a',
    'assets/audio/clarity.m4a',
    'assets/audio/kimi_no_sei.m4a',
    'assets/audio/lullaby.m4a',
    'assets/audio/one_kiss.m4a',
    'assets/audio/racing_into_the_night.mp3',
    'assets/audio/sunflower.mp3',
  ];
  List<String>? pathsListForAddSong = [
    'assets/audio/without_u.m4a',
    'assets/audio/clarity.m4a',
    'assets/audio/kimi_no_sei.m4a',
    'assets/audio/lullaby.m4a',
    'assets/audio/one_kiss.m4a',
    'assets/audio/racing_into_the_night.mp3',
    'assets/audio/sunflower.mp3',
    'abc',
  ];
  List<String>? pathsListForDeleteSongs = [
    'assets/audio/clarity.m4a',
    'assets/audio/kimi_no_sei.m4a',
    'assets/audio/lullaby.m4a',
    'assets/audio/one_kiss.m4a',
    'assets/audio/racing_into_the_night.mp3',
    'assets/audio/sunflower.mp3',
  ];

  test('get path of song when user chose songs form local phone', () {
    provider.getPaths();
    expect(provider.pathsList, pathsList);
  });
  test('add a new song to the songlist', () {
    provider.addSong(tInput);
    expect(provider.pathsList, pathsListForAddSong);
  });

  test('generate filepaths into song name and add into list', () {
    provider.firstTime = true;
    provider.getSongs();
    expect(provider.songs, songs);
  });
  test('delete song form songlist', () {
    provider.getPaths();
    provider.getSongs();
    provider.deleteSong(0);
    expect(provider.pathsList, pathsListForDeleteSongs);
  });
}
