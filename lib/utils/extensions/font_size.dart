import 'package:flutter/material.dart';

extension SpExtensions on num {
  double get cSp =>
      WidgetsBinding.instance.platformDispatcher.textScaleFactor * this;
}
