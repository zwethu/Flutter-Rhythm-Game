import 'dart:math';

import 'package:flutter/cupertino.dart';

class GameAnimationProvider extends ChangeNotifier {
  int mark = 0;
  double topLocation = 1.0;
  double rightLocation = 1.0;
  List<double> topLocations = List<double>.filled(15, 1.0);
  List<double> rightLocations = List<double>.filled(15, 1.0);
  List<bool> boolsList = List<bool>.filled(15, true);

  GameAnimationProvider(double width, double height) {
    setLocation(width, height);
    generateBoolList();
  }

  void setLocation(double width, double height) {
    for (int i = 0; i < 15; i++) {
      topLocation = height * (Random.secure().nextInt(90).toDouble() / 100);
      rightLocation = width * (Random.secure().nextInt(85).toDouble() / 100);
      topLocations[i] = topLocation;
      rightLocations[i] = rightLocation;
    }
  }

  void getAnotherLocation(double width, double height, int index) {
    topLocation = height * (Random.secure().nextInt(90).toDouble() / 100);
    rightLocation = width * (Random.secure().nextInt(90).toDouble() / 100);

    topLocations[index] = topLocation;
    rightLocations[index] = rightLocation;
    notifyListeners();
  }

  void generateBoolList() {
    for (int i = 0; i < 15; i++) {
      int number = Random.secure().nextInt(9);
      if (number.isEven) {
        boolsList[i] = false;
      } else if (number.isOdd) {
        boolsList[i] = true;
      }
    }
  }

  void increaseMark() {
    mark++;
    notifyListeners();
  }

  void restartMark() {
    mark = 0;
    notifyListeners();
  }
}
