import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';
import 'package:sprkl_onboarding/controllers/onboarding_controller.dart';
import 'package:sprkl_onboarding/core/config/app_theme.dart';
import 'package:sprkl_onboarding/views/onboarding_view_updated.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final permissionStatus = await Permission.camera.request();

  CameraController? cameraController;
  if (permissionStatus.isGranted) {
    final cameras = await availableCameras();
    final frontCamera = cameras.firstWhere(
      (camera) => camera.lensDirection == CameraLensDirection.front,
    );
    cameraController = CameraController(
      frontCamera,
      ResolutionPreset.max,
    );
    await cameraController.initialize();
  }

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => OnboardingController()),
      ],
      child: SparklOnboarding(cameraController: cameraController),
    ),
  );
}

class SparklOnboarding extends StatelessWidget {
  final CameraController? cameraController;

  const SparklOnboarding({super.key, this.cameraController});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sparkl Onboarding',
      debugShowCheckedModeBanner: false,
      theme: AppTheme().appTheme(context),
      home: OnboardingViewUpdated(cameraController: cameraController),
    );
  }
}
