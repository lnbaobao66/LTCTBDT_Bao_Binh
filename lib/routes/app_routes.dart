import 'package:flutter/material.dart';
import '../features/onboarding/onboarding_ai_screen.dart';
import '../features/onboarding/onboarding_goal_screen.dart';
import '../features/onboarding/onboarding_scan_screen.dart';

final Map<String, WidgetBuilder> appRoutes = {
  '/onboarding_ai': (context) => OnboardingScreen(),
  '/onboarding_goal': (context) => DashboardScreen(),
  '/onboarding_scan': (context) => SetupScreen(),
};
