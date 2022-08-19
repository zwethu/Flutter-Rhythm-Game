import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/reuseable_widgets/show_animation.dart';
import 'package:tap_tap_tap/services/audio_provider.dart';
import 'package:tap_tap_tap/screens/playlist_screen.dart';
import 'package:tap_tap_tap/services/screen_animation_provider.dart';
import 'package:tap_tap_tap/theme.dart';

class MenuScreen extends StatefulWidget {
  const MenuScreen({Key? key}) : super(key: key);

  @override
  State<MenuScreen> createState() => _MenuScreenState();
}

class _MenuScreenState extends State<MenuScreen> {
  int i = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: blackColor,
      body: SafeArea(
        maintainBottomViewPadding: true,
        child: Stack(
          children: [
            for (i = 0; i < 15; i++) ShowAnimation(i: i),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: (() {
                      var player =
                          Provider.of<AudioProvider>(context, listen: false);
                      player.pausePlayer();
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaylistScreen(),
                        ),
                      );
                      var provider = context.read<ScreenAnimationProvider>();
                      provider.pauseAnimation();
                    }),
                    child: const MenuItem(
                      icon: Icons.queue_music_rounded,
                      title: 'Playlist',
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      var player =
                          Provider.of<AudioProvider>(context, listen: false);
                      player.pausePlayer();

                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const PlaylistScreen(),
                        ),
                      );
                      var provider = context.read<ScreenAnimationProvider>();

                      provider.resumeAnimation();
                    },
                    child: const MenuItem(
                      icon: Icons.tune_rounded,
                      title: 'Settings',
                    ),
                  ),
                  const SizedBox(height: 24),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const MenuItem(
                      icon: Icons.arrow_back_rounded,
                      title: 'Back',
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
  }) : super(key: key);

  final String title;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        CircleAvatar(
          backgroundColor: green,
          radius: 25,
          child: Icon(
            icon,
            size: 30,
            color: white,
          ),
        ),
        const SizedBox(width: 16),
        SizedBox(
          width: 120,
          child: Text(
            title,
            style: bigText,
          ),
        ),
      ],
    );
  }
}
