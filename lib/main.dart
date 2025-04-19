import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/auth/views/error/error_screen.dart';
import 'package:hireny/features/auth/views/salary_insights/salary_insights_screen.dart';
import 'package:hireny/features/auth/views/thank_you/thank_you_screen.dart';
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
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
          theme: AppTheme.light,
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
