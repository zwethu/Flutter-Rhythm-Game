import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:simple_ripple_animation/simple_ripple_animation.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/services/screen_animation_provider.dart';

class ShowAnimation extends StatelessWidget {
  const ShowAnimation({
    Key? key,
    required this.i,
  }) : super(key: key);

  final int i;

  @override
  Widget build(BuildContext context) {
    return Consumer<ScreenAnimationProvider>(builder: (_, provider, child) {
      return Positioned(
        top: provider.topLocations[i],
        right: provider.rightLocations[i],
        child: RippleAnimation(
          repeat: false,
          color: Colors.blue,
          minRadius: 50,
          ripplesCount: 3,
          child: CircleAvatar(
            radius: 25,
            backgroundColor: provider.boolsList[i] ? lightGreen : green,
          ),
        ),
      );
    });
  }
}
