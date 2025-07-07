import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_state.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/job_detailes_screen_content.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/dialogs/error_dialog.dart';

class JobDetailesScreen extends StatelessWidget {
  static String routeName = "jobDetailes";

  final int jobId;

  const JobDetailesScreen({super.key, required this.jobId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt.get<JobDetailsCubit>()..fetchJobDetails(jobId),
      child: BlocConsumer<JobDetailsCubit, JobDatailesState>(
        listener: (context, state) {
          if (state is JobDetailsError) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'some thing went wrong'),
            );
          }
          if (state is SubmitApplicationLoading) {
            showDialog(context: context, builder: (_) => LoadingDialog());
          }
          if (state is HideSubmitApplicationLoading) {
            Navigator.pop(context);
          }
          if (state is SubmitApplicationError) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'some thing went wrong'),
            );
          }
          if (state is SubmitApplicationSuccess) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PagesRoute.firstPage,
                (_) => false,
              );
            });
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(
                    message: 'application submitted successfully',
                  ),
            );
          }
        },
        builder: (context, state) {
          var cubit = context.read<JobDetailsCubit>();
          if (state is JobDetailsLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          return JobDetailesContent(job: cubit.jobPost);
        },
      ),
    );
  }
}
