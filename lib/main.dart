import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/app_routes.dart' as AppRoutes;
import 'package:hireny/utils/di/di.dart';
import 'package:hireny/utils/theme.dart';
import 'package:hireny/widget/tabbar.dart';

import 'bloc_observer.dart';
import 'config_app/app_provider.dart';
import 'features/manage_org_account/service_request_tab/presentation/manager/service_applications_cubit.dart';
import 'features/manage_org_account/service_request_tab/presentation/ui/service_request.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  configureDependencies();
  await AppProvider.configApp();
  Bloc.observer = MyBlocObserver();
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
        //  home:BlocProvider(
        //    create: (_) => getIt<ServiceApplicationsCubit>()..getApplications(), // or your cubit constructor
        //    child: ServiceRequest(),
        //  ),
      ),
    );
  }
}
