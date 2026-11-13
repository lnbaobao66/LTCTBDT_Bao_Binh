import 'package:flutter/material.dart';
import '../features/onboarding/onboarding_ai_screen.dart';
import '../features/onboarding/onboarding_goal_screen.dart';
import '../features/onboarding/onboarding_scan_screen.dart';
import '../features/auth/login_screen.dart';
import '../features/auth/register_screen.dart';
import '../features/home/home_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/onboarding_ai': (context) => OnboardingScreen(),
  '/onboarding_goal': (context) => DashboardScreen(),
  '/onboarding_scan': (context) => SetupScreen(),
  '/login': (context) => LoginPage(),
  '/register': (context) => SignUpScreen(),
  '/dashboard': (context) => DashboardPage(),
};
