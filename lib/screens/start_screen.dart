import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/models/screen_animation_provider.dart';
import 'package:tap_tap_tap/reusable_widgets.dart';
import 'package:tap_tap_tap/screens/menu_screen.dart';
import 'package:tap_tap_tap/theme.dart';

class StartScreen extends StatelessWidget {
  const StartScreen({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    double deviceWidth = MediaQuery.of(context).size.width;
    double deviceHeight = MediaQuery.of(context).size.height;
    int i = 0;
    return ChangeNotifierProvider<ScreenAnimationProvider>(
      create: (context) => ScreenAnimationProvider(deviceWidth, deviceHeight),
      child: Consumer<ScreenAnimationProvider>(
        builder: ((context, value, child) {
          return Scaffold(
            backgroundColor: blackColor,
            body: SafeArea(
              maintainBottomViewPadding: true,
              child: Stack(
                children: [
                  for (i = 0; i < 15; i++)
                    ShowAnimation(
                      i: i,
                      provider: value,
                    ),
                  StartButton(
                    deviceWidth: deviceWidth,
                    deviceHeight: deviceHeight,
                    provider: value,
                  ),
                ],
              ),
            ),
          );
        }),
      ),
    );
  }
}

class StartButton extends StatelessWidget {
  const StartButton({
    Key? key,
    required this.deviceWidth,
    required this.deviceHeight,
    required this.provider,
  }) : super(key: key);

  final double deviceWidth;
  final double deviceHeight;
  final ScreenAnimationProvider provider;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: GestureDetector(
        onTap: () {
          provider.changeLocation(deviceWidth, deviceHeight);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const MenuScreen()),
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
