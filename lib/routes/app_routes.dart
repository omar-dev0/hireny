import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/reset_password/reset_password.dart';
import 'package:hireny/features/auth/view/forget_password/verift_email_screen.dart';
import 'package:hireny/features/my_assessment/presentation/ui/my_assessment.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/ui/org_profile.dart';
import 'package:hireny/features/organization/view/explore_job_seekers_org.dart';
import 'package:hireny/features/profile/presentation/manager/my_courses_cubit.dart';
import 'package:hireny/features/profile/presentation/views/my_courses_view.dart';
import 'package:hireny/features/seeker/view/screens/courses/cubit/course_cubit.dart';
import 'package:hireny/features/seeker/view/screens/courses/explore_courses_seeker.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/explore_job_seeker.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/salary_insights_screen.dart';
import 'package:hireny/features/show_courses/presentation/ui/manager/seeker_course_cubit.dart';
import 'package:hireny/features/show_courses/presentation/ui/show_courses_ui.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/ui/view_application.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/widget/tabbar.dart';
import '../core/widgets/sideBar.dart';

import '../features/admin/view/personal_profile_admin.dart';
import '../features/admin/view/verify_organization_admin.dart';
import '../features/assessment/presentation/ui/assessment.dart';
import '../features/auth/view/forget_password/verfy_otp/verfy_otp.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/auth/view/profile/cubit/user_cubit.dart';
import '../features/auth/view/profile/general_info.dart';
import '../features/auth/view/profile/widgets/change_password.dart';
import '../features/auth/view/profile/widgets/general_tech_info.dart';
import '../features/auth/view/reg/reg_screen.dart';
import '../features/course_detailes/presentation/views/course_details_view.dart';
import '../features/course_detailes/presentation/views/widgets/calender_view.dart';
import '../features/organization/view/explore_organizations_org.dart';
import '../features/organization/view/explore_services_org.dart';
import '../features/organization/view/related_services_org.dart';
import '../features/organization/view/service_details_org.dart';
import '../features/seeker/view/screens/course_details/course_screen_seeker_details.dart';
import '../features/seeker/view/screens/course_details/cubit/course_details_cubit.dart';
import '../features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import '../features/seeker/view/screens/job_detailes/job_detailes_screen.dart';
import '../technical_info/presentation/technical_view.dart';
import '../utils/constants/app_colors.dart';
import '../utils/data_shared/app_shared_data.dart';
import '../utils/di/di.dart';
import '../views/error/error_screen.dart';

Route<dynamic> GeneratedRoute(RouteSettings settings) {
  final name = settings.name;

  if (name == PagesRoute.firstPage && AppSharedData.user?.accessToken == null) {
    return MaterialPageRoute(builder: (_) => LoginScreen());
  } else if (name == PagesRoute.firstPage &&
      AppSharedData.user?.accessToken != null) {
    return MaterialPageRoute(builder: (_) => TabBarApp());
  }

  if (name == PagesRoute.mainScreen) {
    return MaterialPageRoute(builder: (_) => TabBarApp());
  }
  if (name == PagesRoute.generalInfo) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<UserCubit>()..loadData(),
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

  // if (name == PagesRoute.courseDetails) {
  //   return MaterialPageRoute(builder: (_) => CourseDetailsView());
  // }
  if (name == PagesRoute.calender) {
    return MaterialPageRoute(builder: (_) => CalenderView());
  }
  if (name == PagesRoute.myCourses) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (_) => getIt.get<MyCoursesCubit>(),
            child: MyCoursesView(),
          ),
    );
  }

  if (name == PagesRoute.salaryInsights) {
    return MaterialPageRoute(builder: (_) => SalaryInsightsScreen());
  }
  if (name == PagesRoute.assessment) {
    return MaterialPageRoute(builder: (_) => Assessment());
  }
  if (name == PagesRoute.techInfo) {
    return MaterialPageRoute(builder: (_) => const TechnicalInfoView());
  }
  if (name == PagesRoute.changePassword) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<UserCubit>(),
            child: ChangePassword(),
          ),
    );
  }
  if (name == PagesRoute.myApplication) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (_) => getIt.get<AppCubit>(),
            child: ViewApplication(),
          ),
    );
  }
  // if (name == PagesRoute.myAssessment) {
  //   return MaterialPageRoute(
  //     builder:
  //         (_) => BlocProvider(
  //       create: (_) => getIt.get<AppCubit>(),
  //       child: MyAssessment(),
  //     ),
  //   );

  if (name == PagesRoute.myAssessment) {
    return MaterialPageRoute(builder: (_) => MyAssessment());
  }

  if (name == PagesRoute.orgProfile) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (_) => getIt.get<OrgProfileCubit>(),
            child: OrgProfile(),
          ),
    );
  }

  if (name == PagesRoute.reg) {
    bool isOrg = false;
    var arg = settings.arguments;
    if (arg != null && arg is bool) {
      isOrg = arg;
    }
    return MaterialPageRoute(builder: (_) => RegSeekerScreen(isOrg: isOrg));
  }
  if (name == PagesRoute.personalProfileAdmin) {
    return MaterialPageRoute(builder: (_) => PersonalProfileAdmin());
  }
  if (name == PagesRoute.verifyOrganizationAdmin) {
    return MaterialPageRoute(builder: (_) => VerifyOrganizationAdmin());
  }
  if (name == PagesRoute.serviceDetailsOrg) {
    return MaterialPageRoute(builder: (_) => ServiceDetailsOrg());
  }
  if (name == PagesRoute.relatedServicesOrg) {
    return MaterialPageRoute(builder: (_) => RelatedServicesOrg());
  }

  if (name == PagesRoute.exploreOrganizationsOrg) {
    return MaterialPageRoute(builder: (_) => ExploreOrganizationsOrg());
  }
  if (name == PagesRoute.exploreJobSeekersOrg) {
    return MaterialPageRoute(builder: (_) => ExploreJobSeekersOrg());
  }
  if (name == PagesRoute.exploreServicesOrg) {
    return MaterialPageRoute(builder: (_) => ExploreServicesOrg());
  }
  if (name == PagesRoute.exploreCoursesSeeker) {
    return MaterialPageRoute(builder: (_) => ExploreCoursesSeeker());
  }
  if (name == PagesRoute.exploreJobsSeeker) {
    return MaterialPageRoute(builder: (_) => ExploreJobsForJobSeeker());
  }
  if (name == PagesRoute.courseDetailes) {
    final args = settings.arguments as Map<String, int>?;
    final courseId = args?['courseId'];

    if (courseId != null) {
      return MaterialPageRoute(
        builder: (_) => BlocProvider(
          create: (context) => getIt<CourseDetailsCubit>()..fetchCourseDetails(courseId),
          child: courseScreenSeekerDetails(courseId: courseId),
        ),
      );
    } else {
      return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
  if (name == PagesRoute.jobDetailes) {
    final jobId = settings.arguments as int?;

    if (jobId != null) {
      return MaterialPageRoute(
        builder:
            (_) => BlocProvider(
              create:
                  (context) =>
                      getIt.get<JobDetailsCubit>()..fetchJobDetails(jobId),
              child: JobDetailesScreen(jobId: jobId),
            ),
      );
    } else {
      // Fallback if no jobId is provided
      return MaterialPageRoute(builder: (_) => ErrorScreen());
    }
  }
  if (name == PagesRoute.verifyEmail) {
    return MaterialPageRoute(builder: (_) => VeriftEmailScreen());
  }
  if (name == PagesRoute.otpScreen) {
    return MaterialPageRoute(
      builder: (_) => VerfyOtp(email: settings.arguments as String),
    );
  }
  if (name == PagesRoute.resetPassword) {
    return MaterialPageRoute(
      builder: (_) => ResetPassword(email: settings.arguments as String),
    );
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
