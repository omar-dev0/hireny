import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import 'cubit/explore_org_for_seeker_cubit.dart';
import 'cubit/explore_org_for_seeker_states.dart';
import 'explore_org_for_seeker_content.dart';

class ExploreOrgForSeeker extends StatefulWidget {
  ExploreOrgForSeeker({super.key});

  @override
  State<ExploreOrgForSeeker> createState() => _ExploreOrgForSeekerState();
}

class _ExploreOrgForSeekerState extends State<ExploreOrgForSeeker> {
  @override
  void initState() {
    super.initState();
    // Only fetch data if the list is empty (first time loading or data cleared)
    if (AppSharedData.orgPosts.isEmpty) {
      context.read<OrgPostCubit>().fetchAllOrganizations();
    }
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrgPostCubit, OrgPostState>(
      builder: (context, state) {
        if (state is OrgPostLoading) {
          return LoadingDialog();
        }
        if (state is OrgPostLoading && AppSharedData.orgPosts.isEmpty) {
          // Show a simple loading indicator if no data is loaded yet
          return LoadingDialog();
        } else if (state is OrgPostError && AppSharedData.orgPosts.isEmpty) {
          // Show an error message if there's an error and no data
          return ErrorDialog(message: state.message);
        } else {
          return Scaffold(
            backgroundColor: AppColors.subPrimary,
            body: ExploreOrgForSeekerContent(
              chipLabels: ["Location", "Industry", "Size", "Date Posted"],
              onChipPressed: [
                    () => _showLocationBottomSheet(context),
                    () => _showIndustryBottomSheet(context),
                    () => _showOrganizationSizeBottomSheet(context),
                    () => _showDatePostedBottomSheet(context),
              ],
            ),
          );
        }
      },
    );
  }

  void _showLocationBottomSheet(BuildContext context) {
    final cubit = context.read<OrgPostCubit>();
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
        "United States"
      ],
      initialSelection: cubit.selectedLocationIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateLocationFilter(selectedIndices);
      },
    );
  }

  void _showIndustryBottomSheet(BuildContext context) {
    final cubit = context.read<OrgPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select your industry",
      items: AppSharedData.industries,
      initialSelection: cubit.selectedIndustryIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateIndustryFilter(selectedIndices);
      },
    );
  }

  void _showOrganizationSizeBottomSheet(BuildContext context) {
    final cubit = context.read<OrgPostCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Organization Size",
      items: AppSharedData.organizationSizes,
      initialSelection: cubit.selectedSizeIndices,
      onSelectedIndicesChanged: (selectedIndices) {
        cubit.updateSizeFilter(selectedIndices);
      },
    );
  }

  void _showDatePostedBottomSheet(BuildContext context) {
    final cubit = context.read<OrgPostCubit>();
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
}


