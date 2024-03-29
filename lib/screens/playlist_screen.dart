import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:tap_tap_tap/constants.dart';
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
  String path = '';
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: ((context) => SonglistsProvider()),
      builder: ((context, child) => WillPopScope(
            onWillPop: () async {
              var provider =
                  Provider.of<ScreenAnimationProvider>(context, listen: false);
              provider.resumeAnimation();
              var player = Provider.of<AudioProvider>(context, listen: false);
              player.resumePlayer();
              return true;
            },
            child: SafeArea(
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
                      var provider = context.read<ScreenAnimationProvider>();
                      provider.resumeAnimation();
                      Navigator.pop(context);
                      var player = context.read<AudioProvider>();
                      player.resumePlayer();
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
                      onPressed: () async {
                        var data = context.read<SonglistsProvider>();
                        data.addSong(await getPath());
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
                body: Consumer<SonglistsProvider>(
                  builder: ((context, data, child) {
                    data.openHive();
                    data.getPaths();
                    data.getSongs();
                    return ListView.builder(
                      itemCount: data.songs?.length,
                      itemBuilder: (BuildContext context, int index) {
                        return InkWell(
                          onTap: (() {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => GameScreen(
                                  song: data.pathsList![index],
                                ),
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
                                Expanded(
                                  child: Text(
                                    data.songs?[index] ?? '',
                                    overflow: TextOverflow.ellipsis,
                                    style: normalText,
                                  ),
                                ),
                                IconButton(
                                  onPressed: () {
                                    data.deleteSong(index);
                                  },
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
                    );
                  }),
                ),
              ),
            ),
          )),
    );
  }

  Future<String> getPath() async {
    FilePickerResult? result = await FilePicker.platform.pickFiles();
    if (result != null) {
      File file = File(result.files.single.path!);
      path = file.path;
      return file.path;
    } else {
      // User canceled the picker
      throw Exception('error');
    }
  }
}
