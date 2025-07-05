import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_application/presentation/manager/app_cubit.dart';
import 'package:hireny/features/view_application/presentation/manager/app_states.dart';
import 'package:hireny/features/view_application/presentation/ui/view_application_content.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../utils/constants/dialogs/error_dialog.dart';
import '../../domain/model/user_application.dart';

class ViewApplicationScreen extends StatelessWidget {
  const ViewApplicationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AppCubit>()..getUserApplication(),
      child: BlocConsumer<AppCubit, AppState>(
        builder: (context, state) {
          if (state is SuccessUserAppState) {
            List<SeekerApplication> applications = state.applications;
            int pending =
                applications
                    .map((e) => e.status?.toLowerCase() == 'pending')
                    .toList()
                    .length;
            int rejected =
                applications
                    .map((e) => e.status?.toLowerCase() == 'rejected')
                    .toList()
                    .length;
            int approved =
                applications
                    .map((e) => e.status?.toLowerCase() == 'approved')
                    .toList()
                    .length;
            int completed =
                applications
                    .map((e) => e.status?.toLowerCase() == 'completed')
                    .toList()
                    .length;
            return ViewApplicationContent(
              applications: state.applications,
              pending: pending,
              rejected: rejected,
              approved: approved,
              completed: completed,
            );
          }
          if (state is LoadingUserAppState) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return ViewApplicationContent(
            applications: [],
            pending: 0,
            rejected: 0,
            approved: 0,
            completed: 0,
          );
        },
        listener: (context, state) {
          if (state is ErrorUserAppState) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'can\'t load applications'),
            );
          }
        },
      ),
    );
  }
}
