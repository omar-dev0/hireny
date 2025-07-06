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
  State<ExploreJobsForJobSeeker> createState() =>
      _ExploreJobsForJobSeekerState();
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
        if (state is JobPostLoading) {
          // Show a simple loading indicator if no data is loaded yet
          return LoadingDialog();
        }
        if (state is JobPostLoading && AppSharedData.jobPosts.isEmpty) {
          // Show a simple loading indicator if no data is loaded yet
          return LoadingDialog();
        } else if (state is JobPostError && AppSharedData.jobPosts.isEmpty) {
          // Show an error message if there's an error and no data
          return ErrorDialog(message: state.message);
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
      items: [
        "Afghanistan",
        "Albania",
        "Algeria",
        "Angola",
        "Andorra",
        "Argentina",
        "Aruba",
        "Austria",
        "Azerbaijan",
        "Australia",
        "Bahamas",
        "Bahrain",
        "Bangladesh",
        "Barbados",
        "Belarus",
        "Belgium",
        "Belize",
        "Bermuda",
        "Bolivia",
        "Botswana",
        "Brazil",
        "British Indian Ocean Territory",
        "Brunei Darussalam",
        "Bulgaria",
        "Burkina Faso",
        "Cambodia",
        "Cameroon",
        "Canada",
        "Cayman Islands",
        "Chile",
        "China",
        "Colombia",
        "Costa Rica",
        "Cyprus",
        "Czech",
        "Denmark",
        "Dominica",
        "Dominican",
        "Ecuador",
        "Egypt",
        "Estonia",
        "Ethiopia",
        "Fiji",
        "Finland",
        "France",
        "Gambia",
        "Ghana",
        "Gibraltar",
        "Grenada",
        "Guam",
        "Guatemala",
        "Guernsey",
        "Guyana",
        "Haiti",
        "Honduras",
        "Greece",
        "Hungary",
        "Germany",
        "Hong Kong",
        "Iceland",
        "Iran",
        "Iraq",
        "Indonesia",
        "Israel",
        "Jersey",
        "Jordan",
        "Japan",
        "Kazakhstan",
        "Jamaica",
        "Korea",
        "Italy",
        "Lebanon",
        "Lesotho",
        "Liberia",
        "Lithuania",
        "Luxembourg",
        "Kuwait",
        "Kenya",
        "Macau",
        "Macedonia",
        "Malawi",
        "Malaysia",
        "India",
        "Maldives",
        "Moldova",
        "Monaco",
        "Mauritius",
        "Malta",
        "Mozambique",
        "Morocco",
        "Myanmar",
        "Namibia",
        "Mexico",
        "Nepal",
        "Northern Mariana Islands",
        "Norway",
        "Oman",
        "Nigeria",
        "New Zealand",
        "Palestinian Territories",
        "Panama",
        "Peru",
        "Papua New Guinea",
        "Zimbabwe",
        "Zambia",
        "Virgin Islands",
        "Venezuela",
        "Viet Nam",
        "Portugal",
        "Puerto Rico",
        "Poland",
        "Qatar",
        "Netherlands",
        "Pakistan",
        "Uzbekistan",
        "Uruguay",
        "Ukraine",
        "Uganda",
        "Philippines",
        "Rwanda",
        "Turks And Caicos Islands",
        "Tunisia",
        "Tanzania",
        "Russia",
        "Trinidad And Tobago",
        "Romania",
        "Taiwan",
        "Turkey",
        "Thailand",
        "Saint Kitts And Nevis",
        "Saint Lucia",
        "Senegal",
        "Seychelles",
        "Slovakia",
        "Slovenia",
        "Somalia",
        "Swaziland",
        "Syrian Arab",
        "Sri Lanka",
        "Sweden",
        "United Arab Emirates",
        "Spain",
        "Switzerland",
        "Saudi Arabia",
        "Singapore",
        "United Kingdom",
        "South Africa",
        "United States",
      ],
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
      initialSelection: {
        [
          "All",
          "Last Hour",
          "Last 24 Hours",
          "Last 7 Days",
          "Last 30 Days",
        ].indexOf(cubit.selectedDateFilter),
      },
      onSelectedIndicesChanged: (selectedIndices) {
        final List<String> allDates = [
          "All",
          "Last Hour",
          "Last 24 Hours",
          "Last 7 Days",
          "Last 30 Days",
        ];
        final selectedDate =
            selectedIndices.isNotEmpty
                ? allDates[selectedIndices.first]
                : "All";
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
