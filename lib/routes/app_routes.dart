import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/user_accout/presentation/cubit/user_cubit.dart';
import 'package:hireny/user_accout/presentation/widgets/general_tech_info.dart';

import '../user_accout/presentation/general_info.dart';
import '../utils/constants/app_colors.dart';

abstract class AppRoutes {
  static Route<dynamic> GeneratedRoute(RouteSettings settings) {
    switch (settings.name) {
      case PagesRoute.generalInfo:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (context) => UserCubit(),
                child: GeneralInfo(),
              ),
        );

      case PagesRoute.generalTechInfo:
        return MaterialPageRoute(
          builder:
              (context) => BlocProvider(
                create: (_) => UserCubit(),
                child: GeneralTechInfo(),
              ),
        );
      default:
        return MaterialPageRoute(
          builder:
              (context) => Scaffold(
                backgroundColor: AppColors.primary,
                body: const Center(child: Text("Page Not Found")),
              ),
        );
    }
  }
}
