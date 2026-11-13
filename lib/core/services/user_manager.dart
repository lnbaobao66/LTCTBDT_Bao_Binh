import 'package:flutter/material.dart';

import 'package:flutter/material.dart';

class UserManager {
  static final UserManager _instance = UserManager._internal();
  factory UserManager() => _instance;
  UserManager._internal();

  final ValueNotifier<String> nameNotifier = ValueNotifier('');
  String get name => nameNotifier.value;
  set name(String value) => nameNotifier.value = value;

  String email = '';

  final ValueNotifier<double> heightNotifier = ValueNotifier(175);
  double get height => heightNotifier.value;
  set height(double value) => heightNotifier.value = value;

  final ValueNotifier<double> weightNotifier = ValueNotifier(70);
  double get weight => weightNotifier.value;
  set weight(double value) => weightNotifier.value = value;

  void setUser(String name, String email, {double? height, double? weight}) {
    this.name = name;
    this.email = email;
    if (height != null) this.height = height;
    if (weight != null) this.weight = weight;
  }
}
