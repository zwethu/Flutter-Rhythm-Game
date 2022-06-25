import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/models/screen_animation_provider.dart';
import 'package:tap_tap_tap/reusable_widgets.dart';
import 'package:tap_tap_tap/theme.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({Key? key}) : super(key: key);

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
                  for(i = 0 ; i < 15 ; i++)
                  ShowAnimation(i: i, provider: value),
                  Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        MenuItem(icon: Icons.queue_music_rounded, title: 'Playlist', onTap: (){}),
                        const SizedBox(height: 24),
                        MenuItem(icon: Icons.tune_rounded, title: 'Settings', onTap: (){}),
                        const SizedBox(height: 24),
                        MenuItem(icon: Icons.exit_to_app_rounded, title: 'Exit', onTap: (){}),
                      ],
                    ),
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

class MenuItem extends StatelessWidget {
  const MenuItem({
    Key? key,
    required this.icon,
    required this.title,
    required this.onTap,
  }) : super(key: key);

  final String title;
  final Function onTap;
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

// class MenuButton extends StatelessWidget {
//   const MenuButton({
//     Key? key,
//     required this.title,
//     required this.onTap,
//   }) : super(key: key);

// final String title;
// final Function onTap;

//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: GestureDetector(
//         onTap: onTap(),
//         child: CircleAvatar(
//           backgroundColor: green,
//           radius: 75,
//           child: Text(
//             title,
//             style: bigText,
//           ),
//         ),
//       ),
//     );
//   }
// }
