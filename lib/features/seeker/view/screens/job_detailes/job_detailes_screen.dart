import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_state.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/job_detailes_screen_content.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
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
          // Handle loading/error here if needed
        },
        builder: (context, state) {
          if (state is JobDetailsLoading) {
            return LoadingDialog();
          } else if (state is JobDetailsLoaded) {
            return JobDetailesContent(job: state.jobDetails);
          } else if (state is JobDetailsError) {
            // return Center(child: Text(state.message));
            return ErrorDialog(message: state.message);
          } else {
            return Center(child: Text("Something went wrong."));
          }
        },
      ),
    );
  }
}
