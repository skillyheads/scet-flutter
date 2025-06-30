// lib/utils/responsive_utils.dart
import 'package:flutter/material.dart';

class ResponsiveUtils {
  static bool isTablet(BuildContext context) {
    return MediaQuery.of(context).size.width >= 768;
  }

  static bool isDesktop(BuildContext context) {
    return MediaQuery.of(context).size.width >= 1024;
  }

  static double getScreenWidth(BuildContext context) {
    return MediaQuery.of(context).size.width;
  }

  static int getCrossAxisCount(BuildContext context) {
    final width = getScreenWidth(context);
    if (width >= 1200) return 3;
    if (width >= 768) return 2;
    return 1;
  }

  static double getCardPadding(BuildContext context) {
    if (isDesktop(context)) return 24.0;
    if (isTablet(context)) return 20.0;
    return 16.0;
  }

  static double getAvatarSize(BuildContext context) {
    if (isDesktop(context)) return 80.0;
    if (isTablet(context)) return 70.0;
    return 60.0;
  }

  static double getFontSize(BuildContext context, double baseSize) {
    if (isDesktop(context)) return baseSize + 2;
    if (isTablet(context)) return baseSize + 1;
    return baseSize;
  }
}
