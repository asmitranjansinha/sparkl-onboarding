import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';

class OnboardingView extends StatelessWidget {
  const OnboardingView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Image.asset(
              AppAssets.sparklLogo,
            ),
            Text(
              "Learning Made\nPersonal",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineLarge,
            ),
            Text(
              "A Program designed just for YOU!",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Lottie.asset(
              AppAssets.sparklShapeShiftLottie,
            ),
          ],
        ),
      ),
      bottomNavigationBar: SafeArea(
        minimum: EdgeInsets.all(
          20.0,
        ),
        child: ElevatedButton(
          onPressed: () {},
          child: Text("Next"),
        ),
      ),
    );
  }
}
