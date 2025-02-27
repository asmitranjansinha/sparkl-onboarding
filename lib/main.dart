import 'package:flutter/material.dart';
import 'package:sprkl_onboarding/core/config/app_theme.dart';
import 'package:sprkl_onboarding/views/onboarding_view.dart';

void main() {
  runApp(const SparklOnboarding());
}

class SparklOnboarding extends StatelessWidget {
  const SparklOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkl Onboarding',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.appTheme,
      home: const OnboardingView(),
    );
  }
}
