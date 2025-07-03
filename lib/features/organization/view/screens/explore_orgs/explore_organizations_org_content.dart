import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_search_bar.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/features/organization/view/widgets/explore_organization_card.dart';
import 'package:hireny/features/organization/domain/modules/organization.dart';
import 'package:hireny/routes/page_route.dart';

import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../widgets/explore_organization_card_org.dart';
import 'cubit/explore_organizations_org_cubit.dart';
import 'cubit/explore_organizations_org_states.dart';

class ExploreOrganizationsOrgContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const ExploreOrganizationsOrgContent({
    super.key,
    required this.chipLabels,
    required this.onChipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(height: 20.h),
                CustomSearchBar(
                  hintText: "Search for Organizations",
                  onSearchChanged: (value) {
                    context.read<ExploreOrganizationsOrgCubit>().filterOrgs(value);
                  },
                ),
                SizedBox(height: 20.h),
                Text("Explore Organizations", style: AppFonts.mainText),
                Text(
                  "Discover organizations and connect with top companies.",
                  style: AppFonts.secMain,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20.h),
                DynamicFilterChipsWidget(
                  chipLabels: chipLabels,
                  onChipPressed: onChipPressed,
                  onSelectionChanged: (Set<int> selectedIndices) {
                    // Handle selection changes here
                  },
                ),
                SizedBox(height: 24.h),
                Text("All Organizations (${AppSharedData.orgs.length})", style: AppFonts.mainText),
                SizedBox(height: 15.h),
              ],
            ),
          ),
          BlocBuilder<ExploreOrganizationsOrgCubit, ExploreOrganizationsOrgState>(
            builder: (context, state) {
              if (state is ExploreOrganizationsOrgLoaded && state.orgs.isNotEmpty) {
                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate(
                          (context, index) {
                        final orgPost = state.orgs[index];
                        return FadeInUp(
                          delay: Duration(milliseconds: 100 * index),
                          duration: Duration(milliseconds: 500),
                          child: InkWell(
                            onTap: () {
                              Navigator.pushNamed(
                                context,
                                PagesRoute.orgProfile,
                                arguments: orgPost.id,
                              );
                            },
                            child: ExploreOrganizationCardOrg(
                              orgPost: orgPost,
                            ),
                          ),
                        );
                      },
                      childCount: state.orgs.length,
                    ),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 2.4 / 3.2,
                    ),
                  ),
                );
              } else if (state is ExploreOrganizationsOrgLoaded && state.orgs.isEmpty) {
                return SliverToBoxAdapter(
                  child: Center(
                    child: Text("No organizations found.", style: AppFonts.secMain),
                  ),
                );
              } else {
                return SliverToBoxAdapter(child: Container());
              }
            },
          ),
        ],
      ),
    );
  }
}