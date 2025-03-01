import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sprkl_onboarding/controllers/onboarding_controller.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';

Widget logo(BuildContext context, OnboardingController controller) {
  return AnimatedSwitcher(
    duration: 800.ms,
    child: controller.onBoardingView == 2
        ? Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.sparklLogo,
              width: 25.w(context),
            )
                .animate()
                .slideX(
                  begin: 0.0,
                  end: -1.3,
                  duration: 800.ms,
                  curve: Curves.bounceOut,
                )
                .scale(
                  begin: Offset(2.0, 2.0),
                  end: Offset(1.0, 1.0),
                  duration: 800.ms,
                ),
          )
        : Align(
            alignment: Alignment.center,
            child: Image.asset(
              AppAssets.sparklLogo,
              width: 50.w(context),
            )
                .animate()
                .slideX(
                  begin: -1.0,
                  end: 0.0,
                  duration: 500.ms,
                )
                .scale(
                  begin: Offset(0.5, 0.5),
                  end: Offset(1.0, 1.0),
                  duration: 500.ms,
                ),
          ),
  );
}
