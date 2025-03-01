import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';

Widget buildStackCard(BuildContext context) {
  return Stack(
    clipBehavior: Clip.none,
    alignment: Alignment.center,
    children: [
      Positioned(
        bottom: 18.h(context),
        child: Image.asset(
          AppAssets.stackCard,
          width: 58.w(context),
        ).animate().slideX(
              begin: 1.0,
              end: 0.0,
              duration: 900.ms,
              curve: Curves.bounceOut,
            ),
      ),
      Positioned(
        bottom: 12.h(context),
        child: Image.asset(
          AppAssets.stackCard,
          width: 70.w(context),
        ).animate().slideX(
              begin: 1.0,
              end: 0.0,
              duration: 900.ms,
              curve: Curves.bounceOut,
            ),
      ),
      Positioned(
        bottom: 6.h(context),
        child: Image.asset(
          AppAssets.stackCard,
          width: 80.w(context),
        ).animate().slideX(
              begin: 1.0,
              end: 0.0,
              duration: 900.ms,
              curve: Curves.bounceOut,
            ),
      ),
      Image.asset(
        AppAssets.stackCard,
        width: 100.w(context),
      ).animate().slideX(
            begin: 1.0,
            end: 0.0,
            duration: 900.ms,
            curve: Curves.bounceOut,
          ),
    ],
  );
}
