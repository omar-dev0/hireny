import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/chat_bot/UI/chat_boot_screen.dart';
import 'package:hireny/features/services/presentation/ui/services_view.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/assissment_details_screen.dart';
import 'package:hireny/routes/app_routes.dart' as AppRoutes;
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';
import 'package:hireny/widget/tabbar.dart';

import 'config_app/app_provider.dart';
import 'features/services/presentation/manager/service_org_cubit.dart';
import 'features/services/presentation/ui/service_details.dart';
import 'features/services/presentation/ui/service_post.dart';

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
      ),
    );
  }
}
