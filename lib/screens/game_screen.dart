import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/reusable_widgets.dart';
import 'package:tap_tap_tap/services/audio_provider.dart';
import 'package:tap_tap_tap/services/game_animation_provider.dart';
import 'package:tap_tap_tap/services/game_audio_provider.dart';
import 'package:tap_tap_tap/services/screen_animation_provider.dart';
import 'package:tap_tap_tap/theme.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key, required this.song}) : super(key: key);
  final String song;

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  int i = 0;
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: ((context) => GameAudioProvider()),
        ),
        ChangeNotifierProvider(
          create: ((context) =>
              GameAnimationProvider(deviceWidth, deviceHeight)),
        ),
      ],
      child: Consumer<GameAudioProvider>(
        builder: ((context, player, child) {
          player.playGameAudio(widget.song);
          return WillPopScope(
            onWillPop: () async {
              player.pausePlayer();
              return true;
            },
            child: Scaffold(
              body: SafeArea(
                child: Container(
                  decoration: const BoxDecoration(
                    image: DecorationImage(
                      image: AssetImage('assets/images/black.png'),
                      fit: BoxFit.fill,
                    ),
                  ),
                  child: Column(
                    children: [
                      SizedBox(
                        height: 100,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              padding: const EdgeInsets.only(
                                left: padding3x,
                              ),
                              child: Text(
                                player.duration.toString(),
                                style: normalText,
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                right: padding3x,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  player.pauseGame
                                      ? player.resumePlayer()
                                      : player.pausePlayer();
                                  player.changeBool();
                                },
                                icon: !player.pauseGame
                                    ? const Icon(
                                        Icons.pause_rounded,
                                        color: white,
                                        size: 30,
                                      )
                                    : const Icon(
                                        Icons.play_arrow_rounded,
                                        color: white,
                                        size: 30,
                                      ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Consumer<GameAnimationProvider>(
                        builder: ((context, provider, child) {
                          return Expanded(
                            child: Stack(
                              children: [
                                for (i = 0; i < 15; i++)
                                  ShowBubbles(
                                    i: i,
                                    provider: provider,
                                  ),
                              ],
                            ),
                          );
                        }),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}

class ShowBubbles extends StatelessWidget {
  const ShowBubbles({
    Key? key,
    required this.i,
    required this.provider,
  }) : super(key: key);

  final int i;
  final GameAnimationProvider provider;

  @override
  Widget build(BuildContext context) {
        double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Positioned(
      bottom: provider.topLocations[i],
      right: provider.rightLocations[i],
      child: GestureDetector(
        onTap: () {
          provider.getAnotherLocation(deviceWidth, deviceHeight, i);
        },
        child: CircleAvatar(
          radius: 25,
          backgroundColor: provider.boolsList[i] ? lightGreen : green,
        ),
      ),
    );
  }
}
