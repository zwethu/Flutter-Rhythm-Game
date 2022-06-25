import 'dart:async';
import 'dart:math';

import 'package:flutter/cupertino.dart';

class ScreenAnimationProvider extends ChangeNotifier {
  double topLocation = 1.0;
  double rightLocation = 1.0;
  List<double> topLocations = List<double>.filled(15, 1.0);
  List<double> rightLocations = List<double>.filled(15, 1.0);
  List<bool> boolsList = List<bool>.filled(15, true);

  ScreenAnimationProvider(double width, double height) {
    generateBoolList();
    setLocation(width, height);
    Timer.periodic(
      const Duration(seconds: 1),
      ((timer) => changeLocation(width, height)),
    );
  }

  void setLocation(double width, double height) {
    for (int i = 0; i < 15; i++) {
      topLocation = height * (Random.secure().nextInt(95).toDouble() / 100);
      rightLocation = width * (Random.secure().nextInt(95).toDouble() / 100);
      topLocations[i] = topLocation;
      rightLocations[i] = rightLocation;
    }
    notifyListeners();
  }

  void changeLocation(double width, double height) {
    changeLastLocation(width, height);
    for (int i = 0; i < 14; i++) {
      topLocations[i] = topLocations[i + 1];
      rightLocations[i] = rightLocations[i + 1];
      notifyListeners();
    }
  }

  void changeLastLocation(double width, double height) {

    topLocation = height * (Random.secure().nextInt(90).toDouble() / 100);
    rightLocation = width * (Random.secure().nextInt(90).toDouble() / 100);
    
    topLocations[14] = topLocation;
    rightLocations[14] = rightLocation;
    notifyListeners();
  }

  void generateBoolList() {
    for (int i = 0; i < 15; i++) {
      int number = Random.secure().nextInt(9);
      if (number.isEven) {
        boolsList[i] = false;
        notifyListeners();
      } else if (number.isOdd) {
        boolsList[i] = true;
        notifyListeners();
      }
    }
    
  }
}
