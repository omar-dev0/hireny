import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
        return Scaffold(
          backgroundColor: AppColors.subPrimary,
          body: ExploreJobSeekersContent(
            chipLabels: [
              'Location',
              'Industry',
              'Career Level',
              'Employment Status',
              'Gender',
              'Age',
            ],
            onChipPressed: [
                  () => _showLocationBottomSheet(context),
                  () => showDynamicBottomSheet(
                context: context,
                title: "Select category",
                items: [
                  "Commerce",
                  "Telecommunications",
                  "Hotels & Tourism",
                  "Education",
                  "Financial Services"
                ],
              ),
                  () => showDynamicBottomSheet(
                context: context,
                title: "Select Career Level",
                items: ["No-experience", "Fresher", "Intermediate", "Expert"],
              ),
                  () => showDynamicBottomSheet(
                context: context,
                title: "Select Employment Status",
                items: ["Employed", "Unemployed", "Freelancer"],
              ),
                  () => showDynamicBottomSheet(
                context: context,
                title: "Select Gender",
                items: ["Male", "Female"],
              ),
                  () => showDynamicInputBottomSheet(
                context: context,
                title: "Select Age",
                minHint: "Min Age",
                maxHint: "Max Age",
                buttonText: "Filter",
              ),
            ],
          ),
        );
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select Location",
      items: AppSharedData.countryCityData.keys.toList(),
    );
  }
}