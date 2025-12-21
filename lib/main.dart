import 'package:flutter/material.dart';
import 'screens/dashboard_screen.dart';
import 'screens/overview_screen.dart';
import 'screens/jobs_screen.dart';
import 'screens/analytics_screen.dart';
import 'screens/messages_screen.dart';
import 'screens/profile_screen.dart';
import 'utils/constants.dart';

void main() {
  runApp(JobManagementApp());
}

class JobManagementApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Job Management App', // Direct string use karo
      theme: ThemeData(
        primaryColor: AppColors.primaryGreen,
        colorScheme: ColorScheme.light(
          primary: AppColors.primaryGreen,
          secondary: AppColors.primaryBlue,
          background: AppColors.backgroundWhite,
          surface: AppColors.cardWhite,
        ),
        scaffoldBackgroundColor: AppColors.backgroundWhite,
        appBarTheme: AppBarTheme(
          backgroundColor: AppColors.cardWhite,
          elevation: 0,
          foregroundColor: AppColors.textDark,
        ),
        visualDensity: VisualDensity.adaptivePlatformDensity,
        fontFamily: 'Inter',
      ),
      home: DashboardScreen(),
      debugShowCheckedModeBanner: false,
      routes: {
        '/dashboard': (context) => DashboardScreen(),
        '/overview': (context) => OverviewScreen(),
        '/jobs': (context) => JobsScreen(),
        '/analytics': (context) => AnalyticsScreen(),
        '/messages': (context) => MessagesScreen(),
        '/profile': (context) => ProfileScreen(),
        '/createJob': (context) => JobsScreen(),
      },
    );
  }
}