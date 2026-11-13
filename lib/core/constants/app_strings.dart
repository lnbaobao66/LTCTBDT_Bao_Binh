class AppConstants {
  // App Names
  static const String appName = 'BTL Mobile';
  static const String appVersion = '1.0.0';

  // Default Values
  static const double defaultCalorieGoal = 2000;
  static const double defaultWaterGoal = 2000; // ml
  static const double glassVolume = 250; // ml
  static const double defaultProteinPercentage = 30;
  static const double defaultCarbPercentage = 40;
  static const double defaultFatPercentage = 30;

  // Activity Levels
  static const List<String> activityLevels = [
    'Sedentary',
    'Light',
    'Moderate',
    'Active',
    'Very Active',
  ];

  static const Map<String, double> activityFactors = {
    'Sedentary': 1.2,
    'Light': 1.375,
    'Moderate': 1.55,
    'Active': 1.725,
    'Very Active': 1.9,
  };

  // Gender Options
  static const List<String> genders = ['Male', 'Female', 'Other'];

  // Food Categories
  static const List<String> foodCategories = [
    'Vegetables',
    'Fruits',
    'Proteins',
    'Grains',
    'Dairy',
    'Beverages',
    'Snacks',
    'Other',
  ];

  // Meal Types
  static const List<String> mealTypes = [
    'Breakfast',
    'Lunch',
    'Dinner',
    'Snack',
  ];

  // UI Padding & Spacing
  static const double paddingXSmall = 4.0;
  static const double paddingSmall = 8.0;
  static const double paddingMedium = 16.0;
  static const double paddingLarge = 24.0;
  static const double paddingXLarge = 32.0;

  // Border Radius
  static const double radiusSmall = 4.0;
  static const double radiusMedium = 8.0;
  static const double radiusLarge = 12.0;
  static const double radiusXLarge = 16.0;
  static const double radiusCircle = 50.0;

  // Animation Durations
  static const Duration shortAnimationDuration = Duration(milliseconds: 200);
  static const Duration mediumAnimationDuration = Duration(milliseconds: 300);
  static const Duration longAnimationDuration = Duration(milliseconds: 500);

  // Input Validation
  static const int minNameLength = 2;
  static const int maxNameLength = 50;
  static const int minAge = 10;
  static const int maxAge = 120;
  static const double minHeight = 100; // cm
  static const double maxHeight = 250; // cm
  static const double minWeight = 20; // kg
  static const double maxWeight = 300; // kg

  // BMI Categories
  static const Map<String, String> bmiCategories = {
    'Underweight': 'BMI < 18.5',
    'Normal': '18.5 ≤ BMI < 25',
    'Overweight': '25 ≤ BMI < 30',
    'Obese': 'BMI ≥ 30',
  };

  // Date & Time Formats
  static const String dateFormat = 'dd/MM/yyyy';
  static const String timeFormat = 'HH:mm';
  static const String dateTimeFormat = 'dd/MM/yyyy HH:mm';

  // API and Storage Keys
  static const String userIdKey = 'userId';
  static const String userKey = 'user';
  static const String tokenKey = 'auth_token';
  static const String themeKey = 'theme_mode';

  // Error Messages
  static const String errorLoadingData = 'Unable to load data. Please try again.';
  static const String errorSavingData = 'Unable to save data. Please try again.';
  static const String errorValidation = 'Please check your input and try again.';
  static const String errorNetwork = 'Network error. Please check your connection.';

  // Success Messages
  static const String successSaveData = 'Data saved successfully!';
  static const String successDeleteData = 'Deleted successfully!';
  static const String successUpdateData = 'Updated successfully!';

  // Local Database Box Names
  static const String userBoxName = 'userBox';
  static const String foodBoxName = 'foodBox';
  static const String dailyLogBoxName = 'dailyLogBox';
  static const String waterBoxName = 'waterBox';
  static const String themeBoxName = 'themeBox';
}
