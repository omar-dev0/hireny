import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/dialogs/error_dialog.dart';
import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import 'cubit/explore_seekers_cubit.dart';
import 'cubit/explore_seekers_states.dart';
import 'explore_job_seekers_content.dart';

class ExploreJobSeekersOrg extends StatelessWidget {
  static String routeName = "ExploreJobSeekersOrg";

  const ExploreJobSeekersOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreSeekersCubit, SeekerPostState>(
      listener: (context, state) {
        if (state is SeekerPostLoading) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );
        }
        if (state is SeekerPostError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is SeekerPostLoading && AppSharedData.seekers.isEmpty) {
          return LoadingDialog();
        }
        final cubit = BlocProvider.of<ExploreSeekersCubit>(context);

        return Scaffold(
          backgroundColor: AppColors.subPrimary,
          body: ExploreJobSeekersContent(
            chipLabels: [
              'Location',
              // 'Industry',
              'Career Level',
              'Employment Status',
              'Gender',
              'Age',
            ],
            onChipPressed: [
                  () => _showLocationBottomSheet(context),
                  // () => _showIndustryBottomSheet(context),
                  () => _showCareerLevelBottomSheet(context),
                  () => _showEmploymentStatusBottomSheet(context),
                  () => _showGenderBottomSheet(context),
                  () => _showAgeRangeBottomSheet(context),
            ],
          ),
        );
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreSeekersCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Location",
      items: AppSharedData.countries,
      initialSelection: cubit.selectedLocationIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateLocationFilter(indices);
      },
    );
  }

  // void _showIndustryBottomSheet(BuildContext context) {
  //   final cubit = context.read<ExploreSeekersCubit>();
  //   showDynamicBottomSheet(
  //     context: context,
  //     title: "Select Industry",
  //     items: AppSharedData.industries,
  //     initialSelection: cubit.selectedIndustryIndices,
  //     onSelectedIndicesChanged: (indices) {
  //       cubit.updateIndustryFilter(indices);
  //     },
  //   );
  // }

  void _showCareerLevelBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreSeekersCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Career Level",
      items: AppSharedData.careerLevels,
      initialSelection: cubit.selectedCareerLevelIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateCareerLevelFilter(indices);
      },
    );
  }

  void _showEmploymentStatusBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreSeekersCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Employment Status",
      items: AppSharedData.employmentStatus,
      initialSelection: cubit.selectedEmploymentStatusIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateEmploymentStatusFilter(indices);
      },
    );
  }

  void _showGenderBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreSeekersCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Gender",
      items: ["Male", "Female"],
      initialSelection: cubit.selectedGenderIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateGenderFilter(indices);
      },
    );
  }

  void _showAgeRangeBottomSheet(BuildContext context) {
    final cubit = context.read<ExploreSeekersCubit>();
    showDynamicInputBottomSheet(
      context: context,
      title: "Select Age Range",
      minHint: "Min Age",
      maxHint: "Max Age",
      buttonText: "Filter",
      onpress: (min, max) {
        cubit.updateAgeRangeFilter(min: min, max: max);
      },
    );
  }
}