import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/app_routes.dart';
import 'package:hireny/user_accout/presentation/general_info.dart';
import 'package:hireny/user_accout/presentation/widgets/general_tech_info.dart';
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/extensions/theme.dart';

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
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.GeneratedRoute,

      ),
    );
  }
}
