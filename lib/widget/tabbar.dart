import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/organization/view/explore_job_seekers_org.dart';
import 'package:hireny/features/organization/view/explore_organizations_org.dart';
import 'package:hireny/features/organization/view/explore_services_org.dart';
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
import '../features/seeker/view/screens/courses/explore_courses_seeker.dart';
import '../utils/constants/app_colors.dart';

class TabBarApp extends StatelessWidget {
  TabBarApp({super.key});
  final bool isOrg = AppSharedData.user is OrgAdmin;
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
      ],
      child: DefaultTabController(
        length: isOrg ? 4 : 5,
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
                  // TODO: Handle notification tap
                },
              ),
              IconButton(
                icon: Icon(Icons.person, color: AppColors.white),
                onPressed: () {
                  Navigator.pushReplacementNamed(
                    context,
                    PagesRoute.generalInfo,
                  );
                },
              ),
            ],
            bottom: TabBar(
              isScrollable: true,
              labelPadding: EdgeInsets.symmetric(horizontal: 16),
              labelColor: AppColors.white,
              tabAlignment: TabAlignment.start,
              unselectedLabelColor: AppColors.white,
              indicatorColor: AppColors.white,
              tabs:
                  isOrg
                      ? [
                        Tab(text: 'Home'),
                        Tab(text: 'job seekers'),
                        Tab(text: 'services'),
                        Tab(text: 'organizations'),
                      ]
                      : [
                        Tab(text: 'Home'),
                        Tab(text: 'Jobs'),
                        Tab(text: 'Organizations'),
                        Tab(text: 'Courses'),
                        Tab(text: 'Insights'),
                      ],
            ),
          ),
          body: TabBarView(
            children:
                isOrg
                    ? [
                      Home(),
                      ExploreJobSeekersOrg(),
                      ExploreServicesOrg(),
                      ExploreOrganizationsOrg(),
                    ]
                    : [
                      Home(),
                      ExploreJobsForJobSeeker(),
                      ExploreOrgForSeeker(),
                      ExploreCoursesSeeker(),
                      SalaryInsightsScreen(),
                    ],
          ),
        ),
      ),
    );
  }
}
