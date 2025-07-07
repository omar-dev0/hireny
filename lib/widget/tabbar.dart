import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/chat/ui/cubit/chat_cubit.dart';
import 'package:hireny/config_app/notification_service.dart';
import 'package:hireny/features/auth/view/login/login_screen.dart';
import 'package:hireny/features/chat_bot/UI/chat_boot_screen.dart';
import 'package:hireny/features/notification/ui/cubit/notification_cubit.dart';
import 'package:hireny/features/notification/ui/notification_screen.dart';
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
import 'package:hireny/utils/data_shared/data_const.dart';
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/widget/chat_button.dart';
import 'package:hive/hive.dart';

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
  ChatCubit? chatCubit;
  @override
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
              (context) =>
                  getIt.get<JobPostCubit>()
                    ..fetchNotAppliedJobPosts()
                    ..getBestThree(),
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
        BlocProvider(
          create:
              (context) => getIt.get<ExploreSeekersCubit>()..fetchAllSeekers(),
        ),
        BlocProvider(
          create:
              (context) =>
                  getIt.get<ExploreServicesCubit>()..fetchAllServices(),
        ),
        BlocProvider(
          create:
              (context) =>
                  getIt.get<ExploreOrganizationsOrgCubit>()..fetchAllOrgs(),
        ),
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
                onPressed: () {
                  Hive.box(CashingData.appBox).clear();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => LoginScreen()),
                    (_) => false,
                  );
                },
                icon: Icon(Icons.logout, color: Colors.white),
              ),
              IconButton(
                icon: Icon(Icons.notifications, color: AppColors.white),
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => NotificationScreen()),
                  );
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
          floatingActionButton: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              ChatFAB(unreadCount: calcNotReadMessage()),
              const SizedBox(height: 16),
              FloatingActionButton(
                onPressed: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => ChatBootScreen()),
                  );
                },
                backgroundColor: AppColors.primary,
                child: Icon(Icons.smart_toy, color: AppColors.white),
              ),
            ],
          ),
        ),
      ),
    );
  }

  int calcNotReadMessage() {
    int number = 0;
    if (chatCubit?.chatResponse?.conversations != null) {
      for (var element in chatCubit!.chatResponse!.conversations) {
        number += element.unreadCount;
      }
    }
    return number;
  }
}
