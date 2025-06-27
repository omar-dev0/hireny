import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import 'cubit/explore_job_cubit.dart';
import 'cubit/explore_job_states.dart';
import 'explore_job_for_job_seeker_content.dart';

class ExploreJobsForJobSeeker extends StatelessWidget {

  ExploreJobsForJobSeeker({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<JobPostCubit, JobPostState>(
      listener: (context, state) {
        if (state is JobPostLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );
        }

        if (state is JobPostError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is JobPostLoading) {
          return LoadingDialog();
        } else {
          return JobContent(
            chipLabels: [
              'Location',
              'Category',
              'Job Type',
              'Job Location',
              'Experience Level',
              'Date Posted',
              'Salary',
            ],
            onChipPressed: [
              () => _showLocationBottomSheet(context),
              () => showDynamicBottomSheet(
                context: context,
                title: "Select your category",
                items: AppSharedData.categories,
              ),
              () => showDynamicBottomSheet(
                context: context,
                title: "Select Job Type",
                items: AppSharedData.employmentStatus,
              ),
              () => showDynamicBottomSheet(
                context: context,
                title: "Select Job Location",
                items: AppSharedData.jobLocationTypes,
              ),
              () => showDynamicBottomSheet(
                context: context,
                title: "Select Experience Level",
                items: AppSharedData.careerLevels,
              ),
              () => showDynamicBottomSheet(
                context: context,
                title: "Select Date Posted",
                items: [
                  "All",
                  "Last Hour",
                  "Last 24 Hours",
                  "Last 7 Days",
                  "Last 30 Days",
                ],
              ),
              () => showDynamicInputBottomSheet(
                context: context,
                title: "Select Salary Range",
                minHint: "Min Salary",
                maxHint: "Max Salary",
                buttonText: "Filter",
              ),
            ],
          );
        }
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select Location",
      items: AppSharedData.countries,
    );
  }
}
