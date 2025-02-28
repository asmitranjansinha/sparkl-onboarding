import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sprkl_onboarding/controllers/onboarding_controller.dart';
import 'package:sprkl_onboarding/core/config/app_theme.dart';
import 'package:sprkl_onboarding/views/onboarding_view.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
      ],
      child: const SparklOnboarding(),
    ),
  );
}

class SparklOnboarding extends StatelessWidget {
  const SparklOnboarding({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkl Onboarding',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme(context),
      home: const OnboardingView(),
    );
  }
}
