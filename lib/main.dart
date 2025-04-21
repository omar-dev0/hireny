import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/app_routes.dart';
import 'package:hireny/user_accout/presentation/general_info.dart';
import 'package:hireny/user_accout/presentation/widgets/general_tech_info.dart';
import 'package:hireny/features/auth/views/error/error_screen.dart';
import 'package:hireny/features/auth/views/salary_insights/salary_insights_screen.dart';
import 'package:hireny/features/auth/views/thank_you/thank_you_screen.dart';
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
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: AppTheme.light,
        routes: RoutesMap.routes,
        initialRoute: RoutesName.login,
        debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: AppRoutes.GeneratedRoute,

        initialRoute: SalaryInsightsScreen.routeName,
        routes: {
          ErrorScreen.routeName : (_) => ErrorScreen(),
          ThankYouScreen.routeName : (_) => ThankYouScreen(),
          SalaryInsightsScreen.routeName : (_) => SalaryInsightsScreen()
        },
      ),
    );
  }
}
