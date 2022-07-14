import 'dart:math';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/services/audio_provider.dart';
import 'package:tap_tap_tap/services/screen_animation_provider.dart';
import 'package:tap_tap_tap/reusable_widgets.dart';
import 'package:tap_tap_tap/screens/menu_screen.dart';
import 'package:tap_tap_tap/theme.dart';

class StartScreen extends StatefulWidget {
  const StartScreen({Key? key}) : super(key: key);

  @override
  State<StartScreen> createState() => _StartScreenState();
}

class _StartScreenState extends State<StartScreen> {
  final randomNumber = Random().nextInt(6);

  @override
  Widget build(BuildContext context) {
    var player = Provider.of<AudioProvider>(context, listen: false);
    player.playAudio(url[randomNumber]);
    return const AnimatedScreen();
  }
}

// ignore: must_be_immutable
class AnimatedScreen extends StatefulWidget {
  const AnimatedScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AnimatedScreen> createState() => _AnimatedScreenState();
}

class _AnimatedScreenState extends State<AnimatedScreen> {
  int i = 0;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    Provider.of<ScreenAnimationProvider>(context, listen: false)
        .startAnimation(deviceWidth, deviceHeight);
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Consumer<ScreenAnimationProvider>(
          builder: ((context, provider, child) {
            return Stack(
              children: [
                for (i = 0; i < 15; i++)
                  ShowAnimation(
                    i: i,
                    provider: provider,
                  ),
                StartButton(
                  provider: provider,
                ),
              ],
            );
          }),
        ),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
    required this.provider,
  }) : super(key: key);
  final ScreenAnimationProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const MenuScreen(),
            ),
          );
        },
        child: CircleAvatar(
          backgroundColor: green,
          radius: 75,
          child: Text(
            'Start',
            style: bigText.copyWith(color: white),
          ),
        ),
      ),
    );
  }
}
