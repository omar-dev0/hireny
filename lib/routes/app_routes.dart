import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/my_assessment/presentation/ui/my_assessment.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/ui/org_profile.dart';
import 'package:hireny/features/organization/view/explore_job_seekers_org.dart';
import 'package:hireny/features/profile/presentation/views/course_details_view.dart';
import 'package:hireny/features/profile/presentation/views/widgets/calender_view.dart';
import 'package:hireny/features/seeker/view/explore_courses_seeker.dart';
import 'package:hireny/features/seeker/view/explore_job_seeker.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/ui/view_application.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/widget/tabbar.dart';
import '../core/widgets/sideBar.dart';
import '../features/admin/view/personal_profile_admin.dart';
import '../features/admin/view/verify_organization_admin.dart';
import '../features/assessment/presentation/ui/assessment.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/auth/view/profile/cubit/user_cubit.dart';
import '../features/auth/view/profile/general_info.dart';
import '../features/auth/view/profile/widgets/change_password.dart';
import '../features/auth/view/profile/widgets/general_tech_info.dart';
import '../features/auth/view/reg/reg_screen.dart';
import '../features/organization/view/explore_organizations_org.dart';
import '../features/organization/view/explore_services_org.dart';
import '../features/organization/view/related_services_org.dart';
import '../features/organization/view/service_details_org.dart';
import '../features/profile/presentation/manager/my_courses_cubit.dart';
import '../features/profile/presentation/views/my_courses_view.dart';
import '../features/seeker/view/home_page_seeker.dart';
import '../technical_info/presentation/technical_view.dart';
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
  }
  else if (name == PagesRoute.firstPage &&
      AppSharedData.user?.accessToken != null) {
    return MaterialPageRoute(builder: (_)=>TabBarApp());
  }

  if(name == PagesRoute.mainScreen)
    {
      return MaterialPageRoute(builder: (_)=>TabBarApp());
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

  if (name == PagesRoute.courseDetails) {
    return MaterialPageRoute(builder: (_) => CourseDetailsView());
  }
  if (name == PagesRoute.calender) {
    return MaterialPageRoute(builder: (_) => CalenderView());
  }
  if (name == PagesRoute.myCourses) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
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
  }if (name == PagesRoute.techInfo) {
    return MaterialPageRoute(builder: (_) => const technicalInfoView(),

    );
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
    return MaterialPageRoute(builder: (_) => ExploreJobSeeker());
  }
  if (name == PagesRoute.homePageSeeker) {
    return MaterialPageRoute(builder: (_) => HomePageSeeker());
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
