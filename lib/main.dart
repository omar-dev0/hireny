import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/admin/view/verify_organization_admin.dart';
import 'package:hireny/features/auth/view/login/login_screen.dart';
import 'package:hireny/routes/app_routes.dart';
import 'package:hireny/routes/app_routes.dart' as AppRoutes;
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';

import 'config_app/app_provider.dart';

import 'features/admin/view/personal_profile_admin.dart';
import 'features/organization/view/explore_job_seekers_org.dart';
import 'features/organization/view/explore_organizations_org.dart';
import 'features/organization/view/explore_services_org.dart';
import 'features/organization/view/related_services_org.dart';
import 'features/organization/view/service_details_org.dart';
import 'features/seeker/view/explore_courses_seeker.dart';
import 'features/seeker/view/explore_job_seeker.dart';
import 'features/seeker/view/home_page_seeker.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await AppProvider.configApp();
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
        onGenerateRoute: AppRoutes.GeneratedRoute,
        initialRoute: HomePageSeeker.routeName,
        routes: {
          PersonalProfileAdmin.routeName : (_)=> PersonalProfileAdmin(),
          VerifyOrganizationAdmin.routeName : (_)=> VerifyOrganizationAdmin(),
          ServiceDetailsOrg.routeName : (_)=> ServiceDetailsOrg(),
          RelatedServicesOrg.routeName : (_)=> RelatedServicesOrg(),
          ExploreServicesOrg.routeName : (_)=> ExploreServicesOrg(),
          ExploreOrganizationsOrg.routeName : (_)=> ExploreOrganizationsOrg(),
          ExploreJobSeekersOrg.routeName : (_)=> ExploreJobSeekersOrg(),
          ExploreCoursesSeeker.routeName : (_)=> ExploreCoursesSeeker(),
          ExploreJobSeeker.routeName : (_)=> ExploreJobSeeker(),
          HomePageSeeker.routeName : (_)=> HomePageSeeker(),
        },
      ),
    );
  }
}
