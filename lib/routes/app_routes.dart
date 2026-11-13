
import 'package:flutter/material.dart';
//import '../features/scanner/barcode_scanner_screen.dart';
import '../features/reports/weekly_report_screen.dart';
import '../features/hydration/water_reminder_screen.dart';
import '../features/settings/change_password.dart';
import '../features/profile/acc_manager/profile_information_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/onboarding/onboarding_ai_screen.dart';
import '../features/onboarding/onboarding_goal_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/onboarding/onboarding_scan_screen.dart';
import '../features/home/home_screen.dart';
import '../features/profile/profile_screen.dart';
import '../features/settings/settings_screen.dart';
//import '../features/ai_compare/compare_nutrition_screen.dart';
//import '../features/scanner/nutrition_detail_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  //'/scanner': (context) => ScannerScreen(),
  '/weekly_report': (context) => HealthReportScreen(),
  '/water_reminder': (context) => WaterReminderScreen(),
  '/change_password': (context) => const ChangePasswordScreen(),
  '/login': (context) => LoginPage(),
  '/register': (context) => SignUpScreen(),
  '/dashboard': (context) => DashboardPage(),
  '/onboarding_ai': (context) => OnboardingScreen(),
  '/onboarding_goal': (context) => DashboardScreen(),
  '/onboarding_scan': (context) => SetupScreen(),
  '/profile': (context) => const ProfileScreen(),
  '/settings': (context) => const SettingsPage(),
  '/profile_info': (context) => const ProfileEditorScreen(),
  //'/qr_scan': (context) => ScannerScreen(),
  //'/compare': (context) => ComparisonScreen(),
  //'/nutrition_detail': (context) => ScannedProductScreen(),
 
};
