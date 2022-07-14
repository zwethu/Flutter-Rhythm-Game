import 'package:flutter/material.dart';
import 'package:tap_tap_tap/constants.dart';
import 'package:tap_tap_tap/theme.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({Key? key}) : super(key: key);

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/black.png'),
              fit: BoxFit.fill,
            ),
          ),
          child: Stack(
            children: [
              Positioned(
                right: 24,
                top: 16,
                child: IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.pause_rounded,
                    color: white,
                    size: 30,
                  ),
                ),
              ),
              const Positioned(
                left: 24,
                top: 16,
                child: Text(
                  '4:50',
                  style: normalText,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
