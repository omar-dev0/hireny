import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/org_profile/presentation/ui/org_profile.dart';
import 'package:hireny/features/show_admin/presentation/manager/admin_cubit.dart';
import 'package:hireny/features/show_admin/presentation/ui/show_admins.dart';
import 'package:hireny/features/show_courses/presentation/ui/manager/course_cubit.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/ui/view_application.dart';
import 'package:hireny/features/view_org/presentation/manager/org_cubit.dart';
import 'package:hireny/features/view_org/presentation/ui/view_org.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/di/di.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/show_courses/presentation/ui/show_courses_ui.dart';
import '../features/user_accout/cubit/user_cubit.dart';
import '../features/user_accout/general_info.dart';
import '../features/user_accout/widgets/general_tech_info.dart';
import '../utils/constants/app_colors.dart';
import '../views/error/error_screen.dart';
import '../views/salary_insights/salary_insights_screen.dart';
import '../views/thank_you/thank_you_screen.dart';

abstract class AppRoutes {
  static Route<dynamic> GeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoute.firstPage:
        return MaterialPageRoute(builder: (_)=>LoginScreen());
      case PagesRoute.generalInfo:
        {
          return MaterialPageRoute(
            builder:
                (context) =>
                BlocProvider(
                  create: (context) => getIt.get<UserCubit>(),
                  child: GeneralInfo(),
                ),
          );
        }
      case PagesRoute.generalTechInfo:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => getIt.get<UserCubit>(),
                child: GeneralTechInfo(),
              ),
        );
      case PagesRoute.showCourses:
        return MaterialPageRoute( builder:
            (context) => BlocProvider(
          create: (_) => getIt.get<CourseCubit>(),
          child: ShowCoursesUi(),
        ),);
      case PagesRoute.showOrg:
        return MaterialPageRoute( builder:
            (context) => BlocProvider(
          create: (_) => getIt.get<OrgCubit>(),
          child: ViewOrg(),
        ),);
      case PagesRoute.myApplication:
        return MaterialPageRoute( builder:
            (context) => BlocProvider(
          create: (_) => getIt.get<AppCubit>(),
          child: ViewApplication(),
        ),);

      case PagesRoute.errorScreen:
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      case PagesRoute.showAdmins:
        return MaterialPageRoute( builder:
            (context) => BlocProvider(
          create: (_) => getIt.get<AdminCubit>(),
          child: ShowAdmins(),
        ),);


      case PagesRoute.thankYou:
        return MaterialPageRoute(builder: (_) => ThankYouScreen());
      case PagesRoute.orgProfile:
        return MaterialPageRoute(builder: (_) => OrgProfile());

      case PagesRoute.salaryInsights:
        return MaterialPageRoute(builder: (_) => SalaryInsightsScreen());
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                backgroundColor: AppColors.primary,
                body: const Center(child: Text("Page Not Found")),
              ),
        );
    }
  }
}
