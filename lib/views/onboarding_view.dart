import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sprkl_onboarding/controllers/onboarding_controller.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';
import 'package:sprkl_onboarding/core/config/app_colors.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';
import 'package:video_player/video_player.dart';

class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView>
    with SingleTickerProviderStateMixin {
  late VideoPlayerController _videoController;
  late VideoPlayerController _secondVideoController;
  late AnimationController _animationController;
  late Animation<double> _logoAnimation;
  late Animation<double> _textAnimation;
  late Animation<double> _videoAnimation;
  late Animation<double> _secondVideoAnimation;
  late Animation<Offset> _slideAnimation;
  late Animation<Offset> _stackAnimation;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(AppAssets.studentVideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });

    _secondVideoController = VideoPlayerController.asset(AppAssets.teachervideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _secondVideoController.play();
      });

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 500),
      vsync: this,
    );

    _logoAnimation = Tween<double>(begin: 1.0, end: 0.7).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _textAnimation = Tween<double>(begin: 1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _videoAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _secondVideoAnimation = Tween<double>(begin: -1.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(1.0, 0.0), // Start from the right
      end: Offset.zero, // End at the center
    ).animate(
      CurvedAnimation(
        parent: _animationController,
        curve: Curves.easeInOut,
      ),
    );

    _stackAnimation = Tween<Offset>(
      begin: Offset(1.0, 0.0), // Start from the top
      end: Offset.zero, // End at the center
    ).animate(CurvedAnimation(
      parent: _animationController,
      curve: Curves.bounceInOut,
    ));
  }

  @override
  void dispose() {
    _videoController.dispose();
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final onboardingController = Provider.of<OnboardingController>(context);

    return Scaffold(
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: 5.w(context),
              vertical: 2.h(context),
            ),
            child: Column(
              children: <Widget>[
                AnimatedBuilder(
                  animation: _logoAnimation,
                  builder: (context, child) {
                    return Transform.translate(
                      offset: Offset(
                        -98.w(context) * (1 - _logoAnimation.value),
                        -8.h(context) * (1 - _logoAnimation.value),
                      ),
                      child: Transform.scale(
                        scale: _logoAnimation.value, // Scale down the logo
                        child: Image.asset(
                          AppAssets.sparklLogo,
                          width: 50.w(context),
                        ),
                      ),
                    );
                  },
                ),
                20.verticalSpace,
                // Slide in text when view is 2
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: onboardingController.onBoardingView == 2
                      ? SlideTransition(
                          key: const ValueKey('slideText'),
                          position: _slideAnimation,
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "1-on-1 Live Classes",
                                  textAlign: TextAlign.center,
                                  style:
                                      Theme.of(context).textTheme.headlineLarge,
                                ),
                                5.verticalSpace,
                                Text(
                                  "Learning customized for every student",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyMedium!
                                      .copyWith(
                                        fontSize: 15.sp(context),
                                      ),
                                ),
                                50.verticalSpace,
                              ],
                            ),
                          ),
                        )
                      : SizedBox.shrink(),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: onboardingController.onBoardingView == 1
                      ? AnimatedBuilder(
                          animation: _textAnimation,
                          builder: (context, child) {
                            return Opacity(
                              opacity: _textAnimation.value,
                              child: Transform.translate(
                                offset:
                                    Offset(100 * (1 - _textAnimation.value), 0),
                                child: Column(
                                  children: [
                                    Text(
                                      "Learning Made\nPersonal",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headlineLarge,
                                    ),
                                    5.verticalSpace,
                                    Text(
                                      "A Program designed just for YOU!",
                                      textAlign: TextAlign.center,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyMedium!
                                          .copyWith(
                                            fontSize: 15.sp(context),
                                          ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox.shrink(),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 500),
                  child: onboardingController.onBoardingView == 2
                      ? AnimatedBuilder(
                          key: const ValueKey('secondVideo'), // Unique key
                          animation: _secondVideoAnimation,
                          builder: (context, child) {
                            return Transform.translate(
                              offset: Offset(0,
                                  200.h(context) * _secondVideoAnimation.value),
                              child: ClipRRect(
                                borderRadius:
                                    BorderRadius.circular(20.sp(context)),
                                child: SizedBox(
                                  width: 30.w(context),
                                  height: 10.h(context),
                                  child:
                                      _secondVideoController.value.isInitialized
                                          ? VideoPlayer(_secondVideoController)
                                          : SizedBox.shrink(),
                                ),
                              ),
                            );
                          },
                        )
                      : SizedBox.shrink(), // Empty widget when not visible
                ),
                if (onboardingController.onBoardingView == 2) 30.verticalSpace,
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
        child: Row(
          children: [
            onboardingController.onBoardingView == 1
                ? SizedBox.shrink()
                : Padding(
                    padding: EdgeInsets.only(right: 20.sp(context)),
                    child: InkWell(
                        onTap: () {
                          onboardingController.onBoardingView = 1;
                          if (onboardingController.onBoardingView == 1) {
                            _animationController.reverse();
                          }
                        },
                        child: Icon(Icons.arrow_back)),
                  ),
            Expanded(
              child: ElevatedButton(
                onPressed: () {
                  onboardingController.onBoardingView = 2;
                  if (onboardingController.onBoardingView == 2) {
                    _animationController.forward();
                  }
                },
                child: Text("Next"),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget centerStack(BuildContext context) {
    final onBoardController = context.watch<OnboardingController>();
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        onBoardController.onBoardingView == 2
            ? SizedBox.shrink()
            : Lottie.asset(
                AppAssets.sparklShapeShiftLottie,
                width: 95.w(context),
                fit: BoxFit.cover,
              ),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 500),
          child: onBoardController.onBoardingView == 2
              ? stackCard()
              : SizedBox.shrink(),
        ),
        Stack(
          clipBehavior: Clip.none,
          children: [
            Container(
              width: 65.w(context),
              height: 65.w(context),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: onBoardController.onBoardingView == 2
                    ? null
                    : Border.all(
                        color: AppColors.yellow,
                        width: 2.0,
                      ),
              ),
              padding: EdgeInsets.all(8.sp(context)),
              child: _videoController.value.isInitialized
                  ? AnimatedBuilder(
                      animation: _videoAnimation,
                      builder: (context, child) {
                        return Transform.translate(
                            offset: Offset(
                                0, 16.h(context) * _videoAnimation.value),
                            child: Transform.scale(
                                scale: 1 - 0.7 * _videoAnimation.value,
                                child: ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(160.sp(context)),
                                  child: VideoPlayer(_videoController),
                                )));
                      },
                    )
                  : SizedBox.shrink(),
            ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : DottedBorder(
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
                        height: 6.h(context),
                      ),
                    ),
                  ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : Positioned(
                    top: 17.h(context),
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
                          height: 4.h(context),
                        ),
                      ),
                    ),
                  ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : Positioned(
                    top: 30.h(context),
                    left: -6.w(context),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp(context),
                                    fontFamily:
                                        GoogleFonts.indieFlower().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : Positioned(
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp(context),
                                    fontFamily:
                                        GoogleFonts.indieFlower().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : Positioned(
                    top: 25.h(context),
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
                          style:
                              Theme.of(context).textTheme.bodyMedium!.copyWith(
                                    fontSize: 12.sp(context),
                                    fontFamily:
                                        GoogleFonts.indieFlower().fontFamily,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                      ),
                    ),
                  ),
            onBoardController.onBoardingView == 2
                ? SizedBox.shrink()
                : Positioned(
                    top: 38.h(context),
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
                          height: 4.h(context),
                        ),
                      ),
                    ),
                  ),
          ],
        ),
      ],
    );
  }

  Widget stackCard() {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        Positioned(
          bottom: 18.h(context),
          child: SlideTransition(
            key: const ValueKey('slideStack1'),
            position: _stackAnimation,
            child: Image.asset(
              AppAssets.stackCard,
              width: 58.w(context),
            ),
          ),
        ),
        Positioned(
          bottom: 12.h(context),
          child: SlideTransition(
            key: const ValueKey('slideStack2'),
            position: _stackAnimation,
            child: Image.asset(
              AppAssets.stackCard,
              width: 70.w(context),
            ),
          ),
        ),
        Positioned(
          bottom: 6.h(context),
          child: SlideTransition(
            key: const ValueKey('slideStack3'),
            position: _stackAnimation,
            child: Image.asset(
              AppAssets.stackCard,
              width: 80.w(context),
            ),
          ),
        ),
        SlideTransition(
          key: const ValueKey('slideStack4'),
          position: _stackAnimation,
          child: Image.asset(
            AppAssets.stackCard,
            width: 100.w(context),
          ),
        ),
      ],
    );
  }
}
