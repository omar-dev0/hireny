import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/config_app/notification_service.dart';
import 'package:hireny/features/notification/ui/cubit/notification_cubit.dart';
import 'package:hireny/features/organization/view/screens/explore_orgs/explore_organizations_org.dart';
import 'package:hireny/features/organization/view/screens/explore_services/explore_services_org.dart';
import 'package:hireny/features/seeker/view/screens/courses/cubit/course_cubit.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/cubit/explore_job_cubit.dart';
import 'package:hireny/features/seeker/view/screens/explore_org_seeker/cubit/explore_org_for_seeker_cubit.dart';
import 'package:hireny/features/seeker/view/screens/explore_org_seeker/explore_org_for_seeker.dart';
import 'package:hireny/features/seeker/view/home.dart';
import 'package:hireny/features/seeker/view/screens/explore_job/explore_job_seeker.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/cubit/salary_cubit.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/salary_insights_screen.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/di/di.dart';

import '../config_app/notification_service.dart';
import '../features/auth/domain/modules/seeker/seeker.dart';
import '../features/organization/view/HomeOrg.dart';
import '../features/organization/view/screens/explore_orgs/cubit/explore_organizations_org_cubit.dart';
import '../features/organization/view/screens/explore_seekers/cubit/explore_seekers_cubit.dart';
import '../features/organization/view/screens/explore_seekers/explore_job_seekers_org.dart';
import '../features/organization/view/screens/explore_services/cubit/explore_services_cubit.dart';
import '../features/seeker/view/screens/courses/explore_courses_seeker.dart';
import '../utils/constants/app_colors.dart';

class TabBarApp extends StatefulWidget {
  const TabBarApp({super.key});
  @override
  State<TabBarApp> createState() => _TabBarAppState();
}



class _TabBarAppState extends State<TabBarApp> {
  @override
  void initState() {
    if (!AppSharedData.initNotfication) {
      NotificationService  notificationService  = NotificationService();
      notificationService.init();
      notificationService.connectToWebSocket(AppSharedData.user?.accessToken ?? "");
      AppSharedData.initNotfication = true;
    }

    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create:
              (context) =>
                  getIt.get<CourseCubit>()..fetchNotRegisteredCourses(),
        ),
        BlocProvider(
          create:
              (context) => getIt.get<JobPostCubit>()..fetchNotAppliedJobPosts(),
        ),
        BlocProvider(
          create:
              (context) => getIt.get<OrgPostCubit>()..fetchAllOrganizations(),
        ),
        BlocProvider(create: (context) => getIt.get<SalaryCubit>()),
        BlocProvider(
          create:
              (context) => getIt.get<OrgPostCubit>()..fetchAllOrganizations(),
        ),
        BlocProvider(create: (context)=>getIt.get<ExploreSeekersCubit>()..fetchAllSeekers()),
        BlocProvider(create: (context)=>getIt.get<ExploreServicesCubit>()..fetchAllServices()),
        BlocProvider(create: (context)=>getIt.get<ExploreOrganizationsOrgCubit>()..fetchAllOrgs()),
      ],
      child: DefaultTabController(
        length: AppSharedData.user is Seeker ? 5 : 4,
        child: Scaffold(
          appBar: AppBar(
            automaticallyImplyLeading: false,
            backgroundColor: AppColors.primary,
            title: Text(
              "Hireny",
              style: Theme.of(context).textTheme.titleLarge?.copyWith(
                color: AppColors.white,
                fontWeight: FontWeight.w500,
              ),
            ),
            actions: [
              IconButton(
                icon: Icon(Icons.notifications, color: AppColors.white),
                onPressed: () {
                  Navigator.pushNamed(context, PagesRoute.notifications);
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: AppColors.white),
                onPressed: () {
                  AppSharedData.user is Seeker
                      ? Navigator.pushReplacementNamed(
                        context,
                        PagesRoute.generalInfo,
                      )
                      : Navigator.pushReplacementNamed(
                        context,
                        PagesRoute.orgAccount,
                      );
                },
              ),
            ],
            bottom: TabBar(
              isScrollable: AppSharedData.user is Seeker,
              labelPadding:
                  AppSharedData.user is Seeker
                      ? const EdgeInsets.symmetric(horizontal: 16)
                      : EdgeInsets.zero,
              labelColor: AppColors.white,
              unselectedLabelColor: AppColors.white.withOpacity(0.7),
              indicatorColor: Colors.white,
              indicatorWeight: 3,
              indicatorPadding: const EdgeInsets.symmetric(horizontal: 8),
              tabs:
                  (AppSharedData.user is Seeker)
                      ? const [
                        Tab(text: 'Home'),
                        Tab(text: 'Jobs'),
                        Tab(text: 'Organizations'),
                        Tab(text: 'Courses'),
                        Tab(text: 'Insights'),
                      ]
                      : const [
                        Tab(text: 'Home'),
                        Tab(text: 'Seekers'),
                        Tab(text: 'Services'),
                        Tab(text: 'Organizations'),
                      ],
            ),
          ),
          body:
              AppSharedData.user is Seeker
                  ? TabBarView(
                    children: [
                      Home(),
                      ExploreJobsForJobSeeker(),
                      ExploreOrgForSeeker(),
                      ExploreCoursesSeeker(),
                      SalaryInsightsScreen(),
                    ],
                  )
                  : TabBarView(
                    children: [
                      HomeOrg(),
                      ExploreJobSeekersOrg(),
                      ExploreServicesOrg(),
                      ExploreOrganizationsOrg(),
                    ],
                  ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              Navigator.pushNamed(context, PagesRoute.chatBoot);
            },
            backgroundColor: AppColors.primary,
            child: Icon(Icons.smart_toy, color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
