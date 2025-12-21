import 'package:flutter/material.dart';

class AppColors {
  // Professional Gradient Colors
  static const Color primaryGreen = Color(0xFF00C9A7);
  static const Color primaryBlue = Color(0xFF009EFA);
  static const Color accentBlue = Color(0xFF4A90E2);
  static const Color lightGreen = Color(0xFF6CE5C2);
  static const Color darkBlue = Color(0xFF2C3E50);

  // Status Colors
  static const Color success = Color(0xFF27AE60);
  static const Color warning = Color(0xFFF39C12);
  static const Color error = Color(0xFFE74C3C);
  static const Color info = Color(0xFF3498DB);
  static const Color pending = Color(0xFFF1C40F);

  // Neutral Colors
  static const Color backgroundWhite = Color(0xFFF8F9FA);
  static const Color cardWhite = Color(0xFFFFFFFF);
  static const Color surface = Color(0xFFECF0F1);
  static const Color textDark = Color(0xFF2C3E50);
  static const Color textGrey = Color(0xFF7F8C8D);
  static const Color textLight = Color(0xFFBDC3C7);

  // Gradients
  static LinearGradient primaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [primaryGreen, primaryBlue],
  );

  static LinearGradient secondaryGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [lightGreen, accentBlue],
  );

  static LinearGradient successGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [success, Color(0xFF2ECC71)],
  );

  static LinearGradient warningGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [warning, Color(0xFFF1C40F)],
  );
}

class AppStrings {
  static const String appName = "JobFlow Pro";
  static const String slogan = "Professional Job Management";
}

class AppRoutes {
  static const String dashboard = '/';
  static const String overview = '/overview';
  static const String jobs = '/jobs';
  static const String jobDetail = '/jobDetail';
  static const String analytics = '/analytics';
  static const String messages = '/messages';
  static const String chat = '/chat';
  static const String profile = '/profile';
  static const String createJob = '/createJob';
}