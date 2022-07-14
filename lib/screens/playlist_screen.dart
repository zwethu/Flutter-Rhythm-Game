import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/screens/game_screen.dart';
import 'package:tap_tap_tap/services/audio_provider.dart';
import 'package:tap_tap_tap/services/screen_animation_provider.dart';
import 'package:tap_tap_tap/services/songlists_provider.dart';
import 'package:tap_tap_tap/theme.dart';

class PlaylistScreen extends StatefulWidget {
  const PlaylistScreen({Key? key}) : super(key: key);

  @override
  State<PlaylistScreen> createState() => _PlaylistScreenState();
}

class _PlaylistScreenState extends State<PlaylistScreen> {
  @override
  Widget build(BuildContext context) {
    var player = Provider.of<AudioProvider>(context, listen: true);
    var provider = Provider.of<ScreenAnimationProvider>(context, listen: false);
    return WillPopScope(
      onWillPop: () async {
        provider.resumeAnimation();
        return true;
      },
      child: ChangeNotifierProvider<SonglistsProvider>(
        create: (context) => SonglistsProvider(),
        child: Consumer<SonglistsProvider>(builder: ((context, data, child) {
          data.openHive();
          data.getPaths();
          data.getSongs();
          return SafeArea(
            child: Scaffold(
              backgroundColor: blackColor,
              appBar: AppBar(
                toolbarHeight: 50,
                centerTitle: true,
                backgroundColor: blackColor,
                leading: IconButton(
                  hoverColor: Colors.transparent,
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onPressed: () {
                    provider.resumeAnimation();
                    Navigator.pop(context);
                  },
                  icon: const Icon(Icons.arrow_back_ios_rounded),
                ),
                title: Text(
                  'Playlists',
                  style: bigText.copyWith(color: white),
                ),
                actions: [
                  IconButton(
                    hoverColor: Colors.transparent,
                    splashColor: Colors.transparent,
                    highlightColor: Colors.transparent,
                    onPressed: () {
                     data.deleteAll();
                      // getPath();
                      // data.openHive();
                      // data.addSong('hello');
                    },
                    icon: const Icon(
                      Icons.folder_rounded,
                      size: 40,
                      color: white,
                    ),
                  ),
                  const SizedBox(width: 16),
                ],
              ),
              body: SafeArea(
                child: ListView.builder(
                  itemCount: data.songs?.length,
                  itemBuilder: (BuildContext context, int index) {
                    return InkWell(
                      onTap: (() {
                        player.pausePlayer();
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const GameScreen(),
                          ),
                        );
                      }),
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        height: 90,
                        padding: const EdgeInsets.symmetric(
                          horizontal: padding3x,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              data.songs?[index] ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: normalText,
                            ),
                            IconButton(
                              onPressed: () {},
                              icon: const Icon(
                                Icons.delete_rounded,
                                color: white,
                                size: 30,
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          );
        })),
      ),
    );
  }

  void getPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);

      AudioPlayer player = AudioPlayer();
      await player.setFilePath(file.path);
      var name = file.path
          .split('/data/user/0/com.example.tap_tap_tap/cache/file_picker/');
      print(name[1]);
      print(file.path);
      await player.play();
    } else {
      // User canceled the picker
    }
  }
}
