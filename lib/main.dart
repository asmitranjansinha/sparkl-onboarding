import 'package:flutter/material.dart';
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
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: const OnboardingView(),
    );
  }
}
