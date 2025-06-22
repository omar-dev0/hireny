import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/admin/view/verify_organization_admin.dart';
import 'package:hireny/features/auth/view/login/login_screen.dart';
import 'package:hireny/features/assessment/presentation/ui/assessment.dart';
import 'package:hireny/features/manage_org_account/org_assessment_tab/presentation/ui/org_assessment.dart';
import 'package:hireny/features/manage_org_account/org_rep_tab/presentation/ui/org_rep.dart';
import 'package:hireny/features/manage_org_account/reviews_tab/presentation/ui/review_card.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/presentation/ui/service_request.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/presentation/ui/service_request.dart';
import 'package:hireny/features/user_profile/presentation/ui/user_profile.dart';
import 'package:hireny/routes/app_routes.dart';
import 'package:hireny/routes/app_routes.dart' as AppRoutes;
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';
import 'package:hireny/widget/tabbar.dart';

import 'features/manage_org_account/reviews_tab/presentation/manager/review_cubit.dart';
import 'features/show_courses/presentation/ui/show_courses_ui.dart';

import 'config_app/app_provider.dart';

import 'features/admin/view/personal_profile_admin.dart';
import 'features/organization/view/explore_job_seekers_org.dart';
import 'features/organization/view/explore_organizations_org.dart';
import 'features/organization/view/explore_services_org.dart';
import 'features/organization/view/related_services_org.dart';
import 'features/organization/view/service_details_org.dart';

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
        // onGenerateRoute: AppRoutes.GeneratedRoute,
        // home: TabBar()
      ),
    );
  }
}
