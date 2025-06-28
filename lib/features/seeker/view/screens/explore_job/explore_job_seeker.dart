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

class ExploreJobsForJobSeeker extends StatefulWidget {
  ExploreJobsForJobSeeker({super.key});

  @override
  State<ExploreJobsForJobSeeker> createState() => _ExploreJobsForJobSeekerState();
}

class _ExploreJobsForJobSeekerState extends State<ExploreJobsForJobSeeker> {
  @override
  void initState() {
    super.initState();
    // Only fetch data if the list is empty (first time loading or data cleared)
    if (AppSharedData.jobPosts.isEmpty) {
      context.read<JobPostCubit>().fetchNotAppliedJobPosts();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<JobPostCubit, JobPostState>(
      builder: (context, state) {
        if (state is JobPostLoading && AppSharedData.jobPosts.isEmpty) {
          // Show a simple loading indicator if no data is loaded yet
          return const Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          );
        } else if (state is JobPostError && AppSharedData.jobPosts.isEmpty) {
          // Show an error message if there's an error and no data
          return Scaffold(
            body: Center(
              child: Text("Error loading job posts: ${state.message}"),
            ),
          );
        } else {
          // Always return JobContent once data is available or after initial load
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
                  () => _showCategoryBottomSheet(context),
                  () => _showJobTypeBottomSheet(context),
                  () => _showJobLocationBottomSheet(context),
                  () => _showExperienceLevelBottomSheet(context),
                  () => _showDatePostedBottomSheet(context),
                  () => _showSalaryRangeBottomSheet(context),
            ],
          );
        }
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Location",
      items: AppSharedData.countries,
      initialSelection: cubit.selectedLocationIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateLocationFilter(selectedIndices);
      },
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: AppSharedData.categories,
      initialSelection: cubit.selectedCategoryIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateCategoryFilter(selectedIndices);
      },
    );
  }

  void _showJobTypeBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Job Type",
      items: AppSharedData.employmentStatus,
      initialSelection: cubit.selectedJobTypeIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateJobTypeFilter(selectedIndices);
      },
    );
  }

  void _showJobLocationBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Job Location",
      items: AppSharedData.jobLocationTypes,
      initialSelection: cubit.selectedJobLocationIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateJobLocationFilter(selectedIndices);
      },
    );
  }

  void _showExperienceLevelBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Experience Level",
      items: AppSharedData.careerLevels,
      initialSelection: cubit.selectedExperienceLevelIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateExperienceLevelFilter(selectedIndices);
      },
    );
  }

  void _showDatePostedBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Date Posted",
      items: [
        "All",
        "Last Hour",
        "Last 24 Hours",
        "Last 7 Days",
        "Last 30 Days",
      ],
      initialSelection: {["All", "Last Hour", "Last 24 Hours", "Last 7 Days", "Last 30 Days"].indexOf(cubit.selectedDateFilter)},
      onSelectedIndicesChanged: (selectedIndices) {
        final List<String> allDates = ["All", "Last Hour", "Last 24 Hours", "Last 7 Days", "Last 30 Days"];
        final selectedDate = selectedIndices.isNotEmpty ? allDates[selectedIndices.first] : "All";
        cubit.updateDateFilter(selectedDate);
      },
    );
  }

  void _showSalaryRangeBottomSheet(BuildContext context) {
    final cubit = context.read<JobPostCubit>();
    showDynamicInputBottomSheet(
      context: context,
      title: "Select Salary Range",
      minHint: "Min Salary",
      maxHint: "Max Salary",
      buttonText: "Filter",
      onpress: (min, max) {
        cubit.updateSalaryRangeFilter(min: min, max: max);
      },
    );
  }
}


