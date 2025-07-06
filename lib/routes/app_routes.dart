import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/reset_password/reset_password.dart';
import 'package:hireny/features/auth/view/forget_password/verift_email_screen.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/ai-screen.dart';
import 'package:hireny/features/calender/ui/calender_screen.dart';
import 'package:hireny/features/manage_org_account/reviews_tab/presentation/ui/review_card.dart';
import 'package:hireny/features/my_assessment/presentation/ui/my_assessment_screen.dart';
import 'package:hireny/features/org_account/org_account.dart';
import 'package:hireny/features/org_assessment/presentation/ui/org_assessment.dart';
import 'package:hireny/features/org_profile/presentation/manager/org_profile_cubit.dart';
import 'package:hireny/features/org_profile/presentation/ui/org_profile.dart';
import 'package:hireny/features/organization/domain/modules/service.dart';

import 'package:hireny/features/seeker/view/screens/courses/explore_courses_seeker.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/explore_job_seeker.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/salary_insights_screen.dart';
import 'package:hireny/features/services/presentation/ui/services_view.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';
import 'package:hireny/widget/tabbar.dart';

import '../features/admin/view/personal_profile_admin.dart';
import '../features/admin/view/verify_organization_admin.dart';
import '../features/assessment/presentation/ui/assessment.dart';
import '../features/auth/view/forget_password/verfy_otp/verfy_otp.dart';
import '../features/auth/view/login/login_screen.dart';
import '../features/auth/view/profile/cubit/user_cubit.dart';
import '../features/auth/view/profile/general_info.dart';
import '../features/auth/view/profile/widgets/change_password.dart';
import '../features/auth/view/reg/reg_screen.dart';
import '../features/calender/ui/calender_screen_content.dart';
import '../features/course_detailes/presentation/views/course_details_view.dart';
import '../features/manage_org_account/org_rep_tab/presentation/ui/org_rep.dart';
import '../features/manage_org_account/service_request_tab/presentation/ui/service_request.dart';
import '../features/organization/domain/modules/seeker.dart';
import '../features/organization/view/related_services_org.dart';
import '../features/organization/view/screens/explore_orgs/explore_organizations_org.dart';
import '../features/organization/view/screens/explore_seekers/explore_job_seekers_org.dart';
import '../features/organization/view/screens/explore_seekers/seeker_details_org.dart';
import '../features/organization/view/screens/explore_services/cubit/explore_services_cubit.dart';
import '../features/organization/view/screens/explore_services/explore_services_org.dart';
import '../features/organization/view/screens/explore_services/service_details_org.dart';
import '../features/seeker/domain/modules/org_post.dart';
import '../features/seeker/view/screens/course_details/course_screen_seeker_details.dart';
import '../features/seeker/view/screens/course_details/cubit/course_details_cubit.dart';
import '../features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import '../features/seeker/view/screens/job_detailes/job_detailes_screen.dart';
import '../features/services/presentation/manager/service_org_cubit.dart';
import '../features/services/presentation/ui/service_details.dart';
import '../features/services/presentation/ui/service_post.dart';
import '../features/show_courses/presentation/ui/manager/seeker_course_cubit.dart';
import '../features/show_courses/presentation/ui/views/my_courses_view.dart';
import '../features/view_application/presentation/ui/view_application_screen.dart';
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
    debugPrint("${AppSharedData.user?.role}");

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

  if (name == PagesRoute.errorScreen) {
    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }
  if (name == PagesRoute.orgAccount) {
    return MaterialPageRoute(builder: (context) => OrgAccount());
  }
  if (name == PagesRoute.orgAssessment) {
    return MaterialPageRoute(builder: (context) => OrgAssessment()); // done
  }
  if (name == PagesRoute.orgServiceRequest) {
    return MaterialPageRoute(builder: (context) => ServiceRequest());
  }
  if (name == PagesRoute.orgRep) {
    return MaterialPageRoute(builder: (context) => OrgRep()); //
  }
  if (name == PagesRoute.orgReviewForOrg) {
    return MaterialPageRoute(builder: (context) => ReviewCard());
  }
  if (name == PagesRoute.orgServicePost) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (_) => getIt.get<ServiceOrgCubit>(),
            child: ServicePost(),
          ),
    );
  }
  // if (name == PagesRoute.courseDetails) {
  //   return MaterialPageRoute(builder: (_) => CourseDetailsView());
  // }

  if (name == PagesRoute.errorScreen) {
    return MaterialPageRoute(builder: (context) => ErrorScreen());
  }

  // if (name == PagesRoute.courseDetails) {
  //   return MaterialPageRoute(builder: (_) => CourseDetailsView());
  // }

  // }if (name == PagesRoute.servicePostDetails) {
  //   return MaterialPageRoute(builder: (_) =>
  //       ServiceDetailsScreen());
  // }
  if (name == PagesRoute.orgServices) {
    debugPrint("${AppSharedData.user?.role}");

    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<ServiceOrgCubit>()..loadServices(),
            child: ServicesView(),
          ),
    );
  }
  if (name == PagesRoute.myCourses) {
    return MaterialPageRoute(
      builder:
          (_) => BlocProvider(
            create: (_) => getIt.get<SeekerCoursesCubit>(),
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
  // if (name == PagesRoute.techInfo) {
  //   return MaterialPageRoute(
  //     builder:
  //         (context) => BlocProvider(
  //       create: (context) => getIt.get<TechnicalInfoCubit>(),
  //       child: TechnicalInfoView(),
  //     ),
  //   );
  // }
  if (name == PagesRoute.changePassword) {
    return MaterialPageRoute(
      builder:
          (context) => BlocProvider(
            create: (context) => getIt.get<UserCubit>(),
            child: ChangePassword(),
          ),
    );
  }
  if (name == PagesRoute.calender) {
    return MaterialPageRoute(builder: (_) => CalenderScreen());
  }
  if (name == PagesRoute.myApplication) {
    return MaterialPageRoute(builder: (_) => ViewApplicationScreen());
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
    return MaterialPageRoute(builder: (_) => MyAssessmentScreen());
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
  if(name == PagesRoute.aiTools)
    {
      return MaterialPageRoute(builder: (_)=>AiScreen());
    }
  if (name == PagesRoute.verifyOrganizationAdmin) {
    return MaterialPageRoute(builder: (_) => VerifyOrganizationAdmin());
  }
  if (settings.name == PagesRoute.serviceDetailsOrg) {
    final args = settings.arguments as Map<String, dynamic>;
    final service = args['service'] as ServiceModel;
    final cubit = args['cubit'] as ExploreServicesCubit;

    return MaterialPageRoute(
      builder: (context) => BlocProvider.value(
        value: cubit,
        child: ServiceDetailsOrg(service: service, cubit: cubit),
      ),
    );
  }
  if (name == PagesRoute.seekerDetailsOrg) {
    return MaterialPageRoute(builder: (_) => SeekerDetailsOrg(seeker:settings.arguments as SeekerModel ,));
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
        builder:
            (_) => BlocProvider(
              create:
                  (context) =>
                      getIt<CourseDetailsCubit>()..fetchCourseDetails(courseId),
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

  if (name == PagesRoute.orgProfile) {
    return MaterialPageRoute(
      builder: (_) => OrgProfile(orgPost: settings.arguments as OrgPost,),
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

