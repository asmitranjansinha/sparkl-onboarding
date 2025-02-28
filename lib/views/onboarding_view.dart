import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';
import 'package:sprkl_onboarding/core/config/app_colors.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';
import 'package:video_player/video_player.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  late VideoPlayerController _videoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(AppAssets.studentVideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              vertical: 2.h(context),
            ),
            child: Column(
              children: <Widget>[
                Image.asset(
                  AppAssets.sparklLogo,
                  width: 40.w(context),
                ),
                20.verticalSpace,
                Text(
                  "Learning Made\nPersonal",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                ),
                5.verticalSpace,
                Text(
                  "A Program designed just for YOU!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15.sp(context),
                      ),
                ),
                30.verticalSpace,
                centerStack(context),
              ],
            ),
          ),
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

  Widget centerStack(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Lottie.asset(AppAssets.sparklShapeShiftLottie),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 45.w(context),
              height: 25.h(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: AppColors.yellow,
                  width: 2.0,
                ),
              ),
              padding: EdgeInsets.all(8.sp(context)),
              child: _videoController.value.isInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(160.sp(context)),
                      child: VideoPlayer(_videoController),
                    )
                  : SizedBox.shrink(),
            ),
            DottedBorder(
              borderType: BorderType.Circle,
              color: AppColors.yellow,
              strokeWidth: 2,
              dashPattern: [4, 2],
              child: Container(
                decoration: BoxDecoration(
                  color: AppColors.glass,
                  shape: BoxShape.circle,
                ),
                padding: EdgeInsets.all(6.sp(context)),
                child: Image.asset(
                  AppAssets.blueBook,
                  height: 4.h(context),
                ),
              ),
            ),
            Positioned(
              top: 11.h(context),
              left: -5.w(context),
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: AppColors.yellow,
                strokeWidth: 2,
                dashPattern: [4, 2],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8.sp(context)),
                  child: Image.asset(
                    AppAssets.preReadSelected,
                    height: 3.h(context),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 20.h(context),
              left: -10.w(context),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(60.sp(context)),
                padding: EdgeInsets.all(0),
                color: AppColors.yellow,
                strokeWidth: 4,
                dashPattern: [4, 2],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    borderRadius: BorderRadius.circular(60.sp(context)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.sp(context),
                    horizontal: 5.sp(context),
                  ),
                  child: Text(
                    "Doubt Clarification",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10.sp(context),
                          fontFamily: GoogleFonts.indieFlower().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 2.h(context),
              right: -7.w(context),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(60.sp(context)),
                padding: EdgeInsets.all(0),
                color: AppColors.yellow,
                strokeWidth: 4,
                dashPattern: [4, 2],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    borderRadius: BorderRadius.circular(60.sp(context)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.sp(context),
                    horizontal: 5.sp(context),
                  ),
                  child: Text(
                    "Holistic Well-Being",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10.sp(context),
                          fontFamily: GoogleFonts.indieFlower().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 15.h(context),
              right: -10.w(context),
              child: DottedBorder(
                borderType: BorderType.RRect,
                radius: Radius.circular(60.sp(context)),
                padding: EdgeInsets.all(0),
                color: AppColors.yellow,
                strokeWidth: 4,
                dashPattern: [4, 2],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    borderRadius: BorderRadius.circular(60.sp(context)),
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: 8.sp(context),
                    horizontal: 5.sp(context),
                  ),
                  child: Text(
                    "Personalised",
                    style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontSize: 10.sp(context),
                          fontFamily: GoogleFonts.indieFlower().fontFamily,
                          fontWeight: FontWeight.bold,
                        ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 28.h(context),
              right: -0.1.w(context),
              child: DottedBorder(
                borderType: BorderType.Circle,
                color: AppColors.yellow,
                strokeWidth: 2,
                dashPattern: [4, 2],
                child: Container(
                  decoration: BoxDecoration(
                    color: AppColors.glass,
                    shape: BoxShape.circle,
                  ),
                  padding: EdgeInsets.all(8.sp(context)),
                  child: Image.asset(
                    AppAssets.emoji,
                    height: 3.h(context),
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
