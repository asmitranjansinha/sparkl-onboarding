import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  bool _isView1 = true;

  bool get isView1 => _isView1;

  void toggleView() {
    _isView1 = !_isView1;
    notifyListeners();
  }

  int _onBoardingView = 1;
  int get onBoardingView => _onBoardingView;

  set onBoardingView(int value) {
    _onBoardingView = value;
    notifyListeners();
  }
}
