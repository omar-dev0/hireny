import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/admin/view/verify_organization_admin.dart';
import 'package:hireny/features/auth/view/login/login_screen.dart';
import 'package:hireny/routes/app_routes.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';

import 'features/admin/view/personal_profile_admin.dart';
import 'features/organization/view/explore_job_seekers_org.dart';
import 'features/organization/view/explore_organizations_org.dart';
import 'features/organization/view/explore_services_org.dart';
import 'features/organization/view/related_services_org.dart';
import 'features/organization/view/service_details_org.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
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
        initialRoute: ExploreJobSeekersOrg.routeName,
        routes: {
          PersonalProfileAdmin.routeName : (_)=> PersonalProfileAdmin(),
          VerifyOrganizationAdmin.routeName : (_)=> VerifyOrganizationAdmin(),
          ServiceDetailsOrg.routeName : (_)=> ServiceDetailsOrg(),
          RelatedServicesOrg.routeName : (_)=> RelatedServicesOrg(),
          ExploreServicesOrg.routeName : (_)=> ExploreServicesOrg(),
          ExploreOrganizationsOrg.routeName : (_)=> ExploreOrganizationsOrg(),
          ExploreJobSeekersOrg.routeName : (_)=> ExploreJobSeekersOrg(),
        },
      ),
    );
  }
}
