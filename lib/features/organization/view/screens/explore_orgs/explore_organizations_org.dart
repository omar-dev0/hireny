import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'cubit/explore_organizations_org_cubit.dart';
import 'cubit/explore_organizations_org_states.dart';
import 'explore_organizations_org_content.dart';
import 'package:hireny/utils/constants/helper_functions.dart';

class ExploreOrganizationsOrg extends StatelessWidget {
  static String routeName = "ExploreOrganizationsOrg";

  const ExploreOrganizationsOrg({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ExploreOrganizationsOrgCubit, ExploreOrganizationsOrgState>(
      listener: (context, state) {
        if (state is ExploreOrganizationsOrgLoading && AppSharedData.orgs.isEmpty) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );        }
        if (state is ExploreOrganizationsOrgError) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.message),
          );
        }
      },
      builder: (context, state) {
        if (state is ExploreOrganizationsOrgLoading && AppSharedData.orgs.isEmpty) {
          return LoadingDialog();
        }

        return Scaffold(
          backgroundColor: AppColors.subPrimary,
          body: ExploreOrganizationsOrgContent(
            chipLabels: ['Location', 'Industry', 'Size'],
            onChipPressed: [
                  () => _showLocationBottomSheet(context),
                  () => _showCategoryBottomSheet(context),
                  () => _showOrganizationSizeBottomSheet(context),
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

  void _showCategoryBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: [
        "Commerce",
        "Telecommunications",
        "Hotels & Tourism",
        "Education",
        "Financial Services"
      ],
    );
  }

  void _showOrganizationSizeBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select Organization Size",
      items: AppSharedData.organizationSizes,
    );
  }
}