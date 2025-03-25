import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';
import 'package:hireny/utils/routes/route_map.dart';
import 'package:hireny/utils/routes/route_path.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  runApp(Hireny());
}

class Hireny extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(297, 353),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: RoutesMap.routes,
        initialRoute: RoutesName.login,
      ),
    );
  }
}
