import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/profile/presentation/manager/my_courses_cubit.dart';
import 'package:hireny/features/profile/presentation/views/course_details_view.dart';
import 'package:hireny/features/profile/presentation/views/my_courses_view.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/di/di.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/auth/view/user_accout/cubit/user_cubit.dart';
import '../features/auth/view/user_accout/general_info.dart';
import '../features/auth/view/user_accout/widgets/general_tech_info.dart';
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
      case PagesRoute.errorScreen:
        return MaterialPageRoute(builder: (context) => ErrorScreen());
      case PagesRoute.thankYou:
        return MaterialPageRoute(builder: (_) => ThankYouScreen());
      case PagesRoute.salaryInsightes:
        return MaterialPageRoute(builder: (_) => SalaryInsightsScreen());
      case PagesRoute.myCourses:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
            create: (_) => getIt.get<MyCoursesCubit>(),
            child: MyCoursesView(),
          ),
        );
      case PagesRoute.courseDetails:
        return MaterialPageRoute(builder: (_) => CourseDetailsView());
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
