import 'package:flutter/material.dart';

extension ThemeExtinsion on BuildContext {
  ColorScheme get appColors => Theme.of(this).colorScheme;
}
