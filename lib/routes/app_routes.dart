import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/routes/page_route.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/auth/view/reg/reg_screen.dart';
import '../features/auth/view/user_accout/cubit/user_cubit.dart';
import '../features/auth/view/user_accout/general_info.dart';
import '../features/auth/view/user_accout/widgets/general_tech_info.dart';
import '../utils/constants/app_colors.dart';
import '../utils/data_shared/app_shared_data.dart';
import 'package:flutter/material.dart';

import '../utils/di/di.dart';
import '../views/error/error_screen.dart';
import '../views/salary_insights/salary_insights_screen.dart';
import '../views/thank_you/thank_you_screen.dart';

Route<dynamic> GeneratedRoute(RouteSettings settings) {
  final name = settings.name;

  if (name == PagesRoute.firstPage && AppSharedData.user?.accessToken == null) {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  } else if (name == PagesRoute.firstPage &&
      AppSharedData.user?.accessToken != null) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<UserCubit>(),
            child: GeneralInfo(),
          ),
    );
  }

  if (name == PagesRoute.generalInfo) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<UserCubit>(),
            child: GeneralInfo(),
          ),
    );
  }

  if (name == PagesRoute.generalTechInfo) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (_) => getIt.get<UserCubit>(),
            child: GeneralTechInfo(),
          ),
    );
  }

  if (name == PagesRoute.errorScreen) {
    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }

  if (name == PagesRoute.thankYou) {
    return MaterialPageRoute(builder: (_) => ThankYouScreen());
  }

  if (name == PagesRoute.salaryInsightes) {
    return MaterialPageRoute(builder: (_) => SalaryInsightsScreen());
  }

  if (name == PagesRoute.reg) {
    bool isOrg = false;
    var arg = settings.arguments;
    if (arg != null && arg is bool) {
      isOrg = arg;
    }
    return MaterialPageRoute(builder: (_) => RegSeekerScreen(isOrg: isOrg));
  }

  // Default case
  return MaterialPageRoute(
    builder:
        (context) => Scaffold(
          backgroundColor: AppColors.primary,
          body: const Center(child: Text("Page Not Found")),
        ),
  );
}
