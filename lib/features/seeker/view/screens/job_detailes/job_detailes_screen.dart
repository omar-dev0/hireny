import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/job_detailes_cubit.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/cubit/state/job_detailes_state.dart';
import 'package:hireny/features/seeker/view/screens/job_detailes/job_detailes_screen_content.dart';
import 'package:hireny/utils/di/di.dart';

class JobDetailesScreen extends StatelessWidget {
  JobDetailesScreen({super.key});
  final JobDetailesCubit cubit = getIt.get<JobDetailesCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<JobDetailesCubit, JobDatailesState>(
        builder: (context, state) {
          return JobDetailesContent();
        },
        listener: (context, state) {},
      ),
    );
  }
}
