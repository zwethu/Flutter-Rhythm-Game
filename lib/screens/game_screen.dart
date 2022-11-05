import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/services/game_animation_provider.dart';
import 'package:tap_tap_tap/services/game_audio_provider.dart';
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
      child: Consumer2<GameAudioProvider, GameAnimationProvider>(
        builder: ((context, player, animator, child) {
          player.playGameAudio(widget.song);
          player.player.playerStateStream.listen((state) {
            if (state.processingState == ProcessingState.completed) {
              if (player.songEnd) {
                showDialog(
                  barrierDismissible: false,
                  context: context,
                  builder: (context) => showBox(
                    player,
                    animator,
                  ),
                );
              }
            }
          });
          return WillPopScope(
            onWillPop: () async {
              var player = context.read<GameAudioProvider>();
              player.pausePlayer();
              showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) => showPausedBox(player, animator),
              );
              return false;
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
                              child: Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    color: white,
                                    size: 25,
                                  ),
                                  Consumer<GameAnimationProvider>(
                                    builder: ((context, value, child) => Text(
                                          value.mark.toString(),
                                          style: normalText,
                                        )),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              padding: const EdgeInsets.only(
                                right: padding3x,
                              ),
                              child: IconButton(
                                onPressed: () {
                                  var player =
                                      context.read<GameAudioProvider>();
                                  player.pauseGame
                                      ? player.resumePlayer()
                                      : player.pausePlayer();
                                  player.changeBool();

                                  showDialog(
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) =>
                                        showPausedBox(player, animator),
                                  );
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

  AlertDialog showBox(var player, GameAnimationProvider provider) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      backgroundColor: green,
      title: Center(
        child: Text(
          'Score',
          style: bigText.copyWith(color: white),
        ),
      ),
      content: SizedBox(
        height: 50,
        child: Center(
          child: Text(
            provider.mark.toString(),
            style: normalText,
          ),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  player.pausePlayer();
                  Navigator.pop(context);
                  Navigator.pop(context);
                },
                child: Text(
                  'Exit',
                  style: normalText.copyWith(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  provider.restartMark();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => GameScreen(
                        song: widget.song,
                      ),
                    ),
                  );
                },
                child: Text(
                  'Replay',
                  style: normalText.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  AlertDialog showPausedBox(var player, var provider) {
    return AlertDialog(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(35),
        ),
      ),
      backgroundColor: green,
      title: Center(
        child: Text(
          'Paused',
          style: bigText.copyWith(color: white),
        ),
      ),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: TextButton(
                onPressed: () {
                  player.pausePlayer();
                  Navigator.pop(context);
                  Navigator.pop(context);
                  provider.restartMark();
                },
                child: Text(
                  'Exit',
                  style: normalText.copyWith(color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: TextButton(
                onPressed: () {
                  player.resumePlayer();
                  player.changeBool();
                  Navigator.pop(context);
                },
                child: Text(
                  'Resume',
                  style: normalText.copyWith(color: Colors.white),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}

class ShowBubbles extends StatelessWidget {
  const ShowBubbles({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    return Consumer<GameAnimationProvider>(
        builder: ((context, provider, child) {
      return Positioned(
        bottom: provider.topLocations[i],
        right: provider.rightLocations[i],
        child: GestureDetector(
          onTap: () {
            provider.increaseMark();
            provider.getAnotherLocation(deviceWidth, deviceHeight, i);
          },
          child: CircleAvatar(
            radius: 25,
            backgroundColor: provider.boolsList[i] ? lightGreen : green,
          ),
        ),
      );
    }));
  }
}
