import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:provider/provider.dart';
import 'package:sprkl_onboarding/controllers/onboarding_controller.dart';
import 'package:sprkl_onboarding/core/config/app_assets.dart';
import 'package:sprkl_onboarding/core/config/app_colors.dart';
import 'package:sprkl_onboarding/core/utils/sizer.dart';
import 'package:sprkl_onboarding/views/widgets/logo.dart';
import 'package:sprkl_onboarding/views/widgets/stack_card.dart';
import 'package:video_player/video_player.dart';

class OnboardingViewUpdated extends StatefulWidget {
  const OnboardingViewUpdated({super.key});

  @override
  State<OnboardingViewUpdated> createState() => _OnboardingViewUpdatedState();
}

class _OnboardingViewUpdatedState extends State<OnboardingViewUpdated> {
  late VideoPlayerController _videoController;
  late VideoPlayerController _secondVideoController;

  @override
  void initState() {
    super.initState();
    _videoController = VideoPlayerController.asset(AppAssets.studentVideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _videoController.play();
      });

    _secondVideoController = VideoPlayerController.asset(AppAssets.teacherVideo)
      ..setLooping(true)
      ..initialize().then((_) {
        setState(() {});
        _secondVideoController.play();
      });
  }

  @override
  void dispose() {
    _videoController.dispose();
    _secondVideoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<OnboardingController>(
        builder: (context, onboardingController, child) {
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
                  AnimatedSwitcher(
                    duration: 500.ms,
                    child: onboardingController.onBoardingView == 1
                        ? _buildView1(context, onboardingController)
                        : onboardingController.onBoardingView == 2
                            ? _buildView2(context, onboardingController)
                            : _buildView3(context, onboardingController),
                  ),
                ],
              ),
            ),
          ),
        ),
        bottomNavigationBar: SafeArea(
          minimum: EdgeInsets.all(20.0),
          child: Row(
            children: [
              onboardingController.onBoardingView == 1
                  ? SizedBox.shrink()
                  : Padding(
                      padding: EdgeInsets.only(right: 20.sp(context)),
                      child: InkWell(
                        onTap: () {
                          if (onboardingController.onBoardingView == 2) {
                            onboardingController.isGoingFromView2toView1 = true;
                            onboardingController.isGoingFromView3toView2 =
                                false;
                            onboardingController.onBoardingView = 1;
                          } else if (onboardingController.onBoardingView == 3) {
                            onboardingController.isGoingFromView3toView2 = true;
                            onboardingController.isGoingFromView2toView1 =
                                false;
                            onboardingController.onBoardingView = 2;
                          }
                        },
                        child: Icon(Icons.arrow_back),
                      ),
                    ),
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    if (onboardingController.onBoardingView == 1) {
                      onboardingController.onBoardingView = 2;
                    } else if (onboardingController.onBoardingView == 2) {
                      onboardingController.onBoardingView = 3;
                    }
                  },
                  child: Text("Next"),
                ),
              ).animate().slide(
                    begin: Offset(0.0, 1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut,
                  ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildView1(
      BuildContext context, OnboardingController onboardingController) {
    return Column(
      children: [
        logo(context, onboardingController),
        20.verticalSpace,
        Stack(
          alignment: Alignment.center,
          children: [
            Column(
              children: [
                // Text bounces from right to left and then centers
                Text(
                  "Learning Made\nPersonal",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineLarge,
                )
                    .animate()
                    .slideX(
                        begin: -1.0,
                        end: 0.0,
                        duration: 800.ms,
                        curve: Curves.bounceOut)
                    .fadeIn(duration: 800.ms),
                5.verticalSpace,
                Text(
                  "A Program designed just for YOU!",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                        fontSize: 15.sp(context),
                      ),
                )
                    .animate()
                    .slideX(
                        begin: 1.0,
                        end: 0.0,
                        duration: 800.ms,
                        curve: Curves.bounceOut)
                    .fadeIn(duration: 800.ms),
              ],
            ),
            _teacherVideo(context, onboardingController),
          ],
        ),
        _buildCenterStack(context, onboardingController),
      ],
    );
  }

  Widget _buildView2(
      BuildContext context, OnboardingController onboardingController) {
    return Column(
      children: [
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              logo(context, onboardingController),
              20.verticalSpace,
              Text(
                "1-on-1 Live Classes",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineLarge,
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: 1.0, end: 0.0, duration: 500.ms),
              5.verticalSpace,
              Text(
                "Learning customized for every student",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                      fontSize: 15.sp(context),
                    ),
              )
                  .animate()
                  .fadeIn(duration: 500.ms)
                  .slideX(begin: 1.0, end: 0.0, duration: 500.ms),
            ],
          ),
        ),
        20.verticalSpace,
        _teacherVideo(context, onboardingController),
        30.verticalSpace,
        _buildCenterStack(context, onboardingController),
      ],
    );
  }

  Widget _buildView3(
      BuildContext context, OnboardingController onboardingController) {
    return Column(
      children: [
        logo(context, onboardingController),
        20.verticalSpace,
        Align(
          alignment: Alignment.centerLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Doubt Resolution\nwith Teachers",
                style: Theme.of(context).textTheme.headlineLarge,
              ).animate().fadeIn(duration: 300.ms).slideX(
                    begin: 1.0,
                    end: 0.0,
                    duration: 300.ms,
                  ),
            ],
          ),
        ),
        20.verticalSpace,
        _teacherVideo(context, onboardingController)
      ],
    );
  }

  Widget _buildCenterStack(
      BuildContext context, OnboardingController onBoardController) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.center,
      children: [
        // Lottie animation (only for view 1)
        onBoardController.onBoardingView == 2
            ? SizedBox.shrink()
            : Lottie.asset(
                AppAssets.sparklShapeShiftLottie,
                width: 95.w(context),
                fit: BoxFit.cover,
              ),
        // Stack card (only for view 2)
        onBoardController.onBoardingView == 2
            ? buildStackCard(context)
            : SizedBox.shrink(),
        Stack(
          clipBehavior: Clip.none,
          children: [
            // Video slides from bottom to the stack
            AnimatedSwitcher(
              duration: 800.ms,
              child: onBoardController.onBoardingView == 1
                  ? Container(
                      key: ValueKey(1), // Unique key for View 1
                      width: 65.w(context),
                      height: 65.w(context),
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
                              borderRadius:
                                  BorderRadius.circular(160.sp(context)),
                              child: VideoPlayer(_videoController),
                            )
                              .animate()
                              .slideY(
                                begin: 1.2, // Start from bottom
                                end: 0.0, // Move to top
                                duration: 800.ms,
                              )
                              .scale(
                                begin: Offset(0.4, 0.4), // Start scaled down
                                end: Offset(1.0, 1.0), // Scale up
                                duration: 800.ms,
                              )
                          : SizedBox.shrink(),
                    )
                  : Container(
                      key: ValueKey(2), // Unique key for View 2
                      width: 65.w(context),
                      height: 65.w(context),
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                      ),
                      padding: EdgeInsets.all(8.sp(context)),
                      child: _videoController.value.isInitialized
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(160.sp(context)),
                              child: VideoPlayer(_videoController),
                            )
                              .animate()
                              .slideY(
                                begin: 0.0, // Start from top
                                end: 1.2, // Move to bottom
                                duration: 800.ms,
                              )
                              .scale(
                                begin: Offset(1.0, 1.0), // Start at full size
                                end: Offset(0.4, 0.4), // Scale down
                                duration: 800.ms,
                              )
                          : SizedBox.shrink(),
                    ),
            ),

            // Emojis and books with dotted borders bounce from corners
            if (onBoardController.onBoardingView != 2) ...[
              // Blue book (top-left corner)
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
                    height: 6.h(context),
                  ),
                ),
              ).animate().slide(
                  begin: Offset(-1.0, -1.0),
                  end: Offset.zero,
                  duration: 800.ms,
                  curve: Curves.bounceOut),

              Positioned(
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
                    padding: EdgeInsets.all(6.sp(context)),
                    child: Image.asset(
                      AppAssets.preReadSelected,
                      height: 6.h(context),
                    ),
                  ),
                ).animate().slide(
                    begin: Offset(-1.0, -1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut),
              ),
              // Pre-read selected (top-left corner)
              Positioned(
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp(context),
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ).animate().slide(
                    begin: Offset(-1.0, -1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut),
              ),
              // Holistic Well-Being (top-right corner)
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
                            fontSize: 12.sp(context),
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ).animate().slide(
                    begin: Offset(1.0, -1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut),
              ),
              // Personalised (bottom-right corner)
              Positioned(
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
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                            fontSize: 12.sp(context),
                            fontFamily: GoogleFonts.indieFlower().fontFamily,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ).animate().slide(
                    begin: Offset(1.0, 1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut),
              ),
              // Emoji (bottom-right corner)
              Positioned(
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
                ).animate().slide(
                    begin: Offset(1.0, 1.0),
                    end: Offset.zero,
                    duration: 800.ms,
                    curve: Curves.bounceOut),
              ),
            ],
          ],
        ),
      ],
    );
  }

  Widget _teacherVideo(BuildContext context, OnboardingController controller) {
    return AnimatedSwitcher(
      duration: 800.ms,
      child: (controller.isGoingFromView3toView2 &&
              controller.onBoardingView == 2)
          ? Container(
              width: 40.w(context),
              height: 25.w(context),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10.0.sp(context)),
              ),
              padding: EdgeInsets.all(8.sp(context)),
              child: _videoController.value.isInitialized
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(10.0.sp(context)),
                      child: VideoPlayer(_secondVideoController),
                    )
                      .animate()
                      .slideX(
                        begin: -2.0,
                        end: 0.0,
                        duration: 900.ms,
                        curve: Curves.easeOut,
                      )
                      .scale(
                        begin: Offset(0.5, 0.5),
                        end: Offset(1.0, 1.0),
                        duration: 900.ms,
                        curve: Curves.easeOut,
                      )
                  : SizedBox.shrink(),
            )
          : controller.onBoardingView == 2
              ? Container(
                  width: 40.w(context),
                  height: 25.w(context),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10.0.sp(context)),
                  ),
                  padding: EdgeInsets.all(8.sp(context)),
                  child: _videoController.value.isInitialized
                      ? ClipRRect(
                          borderRadius: BorderRadius.circular(10.0.sp(context)),
                          child: VideoPlayer(_secondVideoController),
                        ).animate().slideY(
                            begin: -3.0,
                            end: 0.0,
                            duration: 600.ms,
                            curve: Curves.easeOut,
                          )
                      : SizedBox.shrink(),
                )
              : controller.isGoingFromView2toView1
                  ? Container(
                      width: 40.w(context),
                      height: 25.w(context),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0.sp(context)),
                      ),
                      padding: EdgeInsets.all(8.sp(context)),
                      child: _videoController.value.isInitialized
                          ? ClipRRect(
                              borderRadius:
                                  BorderRadius.circular(10.0.sp(context)),
                              child: VideoPlayer(_secondVideoController),
                            ).animate().slideY(
                                begin: 0.0,
                                end: -3.0,
                                duration: 600.ms,
                                curve: Curves.easeOut,
                              )
                          : SizedBox.shrink(),
                    )
                  : controller.onBoardingView == 3
                      ? Container(
                          width: 25.w(context),
                          height: 25.w(context),
                          decoration: BoxDecoration(
                            borderRadius:
                                BorderRadius.circular(10.0.sp(context)),
                          ),
                          padding: EdgeInsets.all(8.sp(context)),
                          child: _videoController.value.isInitialized
                              ? ClipRRect(
                                  borderRadius:
                                      BorderRadius.circular(160.0.sp(context)),
                                  child: VideoPlayer(_secondVideoController),
                                )
                                  .animate()
                                  .slideX(
                                    begin: 0.0,
                                    end: -3.8,
                                    duration: 900.ms,
                                    curve: Curves.easeOut,
                                  )
                                  .scale(
                                    begin: Offset(1.0, 1.0),
                                    end: Offset(0.5, 0.5),
                                    duration: 900.ms,
                                    curve: Curves.easeOut,
                                  )
                              : SizedBox.shrink(),
                        )
                      : (controller.onBoardingView == 2 &&
                              controller.isGoingFromView3toView2)
                          ? Container(
                              width: 40.w(context),
                              height: 25.w(context),
                              decoration: BoxDecoration(
                                borderRadius:
                                    BorderRadius.circular(10.0.sp(context)),
                              ),
                              padding: EdgeInsets.all(8.sp(context)),
                              child: _videoController.value.isInitialized
                                  ? ClipRRect(
                                      borderRadius: BorderRadius.circular(
                                          10.0.sp(context)),
                                      child:
                                          VideoPlayer(_secondVideoController),
                                    )
                                      .animate()
                                      .slideX(
                                        begin: -3.8,
                                        end: 0.0,
                                        duration: 900.ms,
                                        curve: Curves.easeOut,
                                      )
                                      .scale(
                                        begin: Offset(1.0, 1.0),
                                        end: Offset(2.0, 2.0),
                                        duration: 900.ms,
                                        curve: Curves.easeOut,
                                      )
                                  : SizedBox.shrink(),
                            )
                          : SizedBox.shrink(),
    );
  }
}
