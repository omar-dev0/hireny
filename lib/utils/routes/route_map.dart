import 'package:flutter/material.dart';
import 'package:hireny/features/auth/view/login/login_screen.dart';
import 'package:hireny/utils/routes/route_path.dart';

abstract class RoutesMap {
  static Map<String, Widget Function(BuildContext)> routes = {
    RoutesName.login: (_) => LoginScreen(),
  };
}
