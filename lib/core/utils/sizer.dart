import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

extension ContextExtensions on BuildContext {
  double get screenHeight => MediaQuery.of(this).size.height;
  double get screenWidth => MediaQuery.of(this).size.width;
  double get textScaleFactor =>
      MediaQuery.of(this).textScaleFactor; // Text scaling
  double get devicePixelRatio =>
      MediaQuery.of(this).devicePixelRatio; // Device pixel ratio
}

// Extension for responsive size calculations on num
extension SizeExtensions on num {
  // Height percentage (h) calculation based on screen height
  double h(BuildContext context, {double scaleFactor = 1.0}) {
    return (this * context.screenHeight / 100) * scaleFactor;
  }

  // Width percentage (w) calculation based on screen width
  double w(BuildContext context) => this * context.screenWidth / 100;

  // For scalable text with an optional scaling factor for better control
  double sp(BuildContext context, {double scaleFactor = 1.0}) {
    if (Platform.isAndroid) {
      scaleFactor = 1.4;
    }
    double baseSize = this * context.textScaleFactor;
    return baseSize *
        scaleFactor; // Adjust scaling factor for cross-platform consistency
  }

  double px(BuildContext context, {double scaleFactor = 1.0}) {
    if (Platform.isAndroid) {
      scaleFactor = 1.4;
    }
    double baseSize = this * context.textScaleFactor;
    return baseSize *
        scaleFactor; // Adjust scaling factor for cross-platform consistency
  }
}

// Function to adjust font size based on platform
double platformAdjustedFontSize(BuildContext context, num size) {
  if (kIsWeb) {
    // For web, use normal scaling with slight adjustments
    return size.sp(context, scaleFactor: 1.0); // No major adjustment for web
  } else if (Platform.isAndroid) {
    return size.sp(context,
        scaleFactor: 1.4); // Adjust scale factor for Android
  } else if (Platform.isIOS) {
    return size.sp(context); // Default scaling for iOS
  } else {
    return size.sp(context); // For other platforms, use default scaling
  }
}

extension Dimensions on int {
  double get _scaleFactor {
    if (kIsWeb) {
      return 1.0; // No scaling adjustment for web
    } else if (Platform.isAndroid) {
      return 2; // 1.5x scaling for Android
    } else if (Platform.isIOS) {
      return 1.0; // No scaling adjustment for iOS
    } else {
      return 1.0; // Default scaling factor for other platforms
    }
  }

  // Returns a horizontally scaled SizedBox (width)
  SizedBox get horizontalSpace => SizedBox(width: toDouble() * _scaleFactor);

  // Returns a vertically scaled SizedBox (height)
  SizedBox get verticalSpace => SizedBox(height: toDouble() * _scaleFactor);
}

// Helper function to detect if the app is running on the web
bool isWeb() => kIsWeb;
