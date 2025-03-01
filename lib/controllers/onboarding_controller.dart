import 'package:flutter/material.dart';

class OnboardingController extends ChangeNotifier {
  int _onBoardingView = 1;
  int get onBoardingView => _onBoardingView;

  set onBoardingView(int value) {
    _onBoardingView = value;
    notifyListeners();
  }

  bool _isGoingFromView2toView1 = false;
  bool get isGoingFromView2toView1 => _isGoingFromView2toView1;

  set isGoingFromView2toView1(bool value) {
    _isGoingFromView2toView1 = value;
    notifyListeners();
  }
}
