import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_search_bar.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import '../../../../../utils/constants/helper_functions.dart';
import '../../../../organization/view/widgets/explore_organization_card.dart';
import 'cubit/explore_org_for_seeker_cubit.dart';
import 'cubit/explore_org_for_seeker_states.dart';

class ExploreOrgForSeekerContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const ExploreOrgForSeekerContent({
    super.key,
    required this.chipLabels,
    required this.onChipPressed,
  });

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<OrgPostCubit>(context);

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
                    context.read<OrgPostCubit>().filterOrgPosts(value);
                  },
                ),
                SizedBox(height: 20.h),

                /// Animated Title
                FadeInDown(
                  duration: Duration(milliseconds: 500),
                  child: Text("Explore Organizations", style: AppFonts.mainText),
                ),
                SizedBox(height: 20.h),

                /// Animated Filter Chips
                BlocBuilder<OrgPostCubit, OrgPostState>(
                  builder: (context, state) {
                    Set<int> selectedChips = {};
                    // Determine which chips are 'selected' based on the cubit's filter state
                    if (cubit.selectedLocationIndices.isNotEmpty) {
                      selectedChips.add(chipLabels.indexOf('Location'));
                    }
                    if (cubit.selectedIndustryIndices.isNotEmpty) {
                      selectedChips.add(chipLabels.indexOf('Industry'));
                    }
                    if (cubit.selectedSizeIndices.isNotEmpty) {
                      selectedChips.add(chipLabels.indexOf('Size'));
                    }
                    if (cubit.selectedDateFilter != 'All') {
                      selectedChips.add(chipLabels.indexOf('Date Posted'));
                    }

                    return DynamicFilterChipsWidget(
                      chipLabels: chipLabels,
                      onChipPressed: onChipPressed,
                      selectedChipIndices: selectedChips,
                    );
                  },
                ),
                SizedBox(height: 20.h),

                /// Animated Sub-Header
                FadeInDown(
                  delay: Duration(milliseconds: 700),
                  child: Text("All Organizations", style: AppFonts.mainText),
                ),
                SizedBox(height: 15.h),
              ],
            ),
          ),

          /// Animated Cards
          BlocBuilder<OrgPostCubit, OrgPostState>(
            builder: (context, state) {
              if (state is OrgPostLoaded && state.orgPosts.isNotEmpty) {
                return SliverPadding(
                  padding: EdgeInsets.only(bottom: 20.h),
                  sliver: SliverGrid(
                    delegate: SliverChildBuilderDelegate((context, index) {
                      final orgPost = state.orgPosts[index];
                      return FadeInUp(
                        delay: Duration(milliseconds: 100 * index),
                        duration: Duration(milliseconds: 500),
                        child: InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, PagesRoute.orgProfile);
                          },
                          child: ExploreOrganizationCard(
                            orgPost: orgPost,
                          ),
                        ),
                      );
                    }, childCount: state.orgPosts.length),
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 10.h,
                      crossAxisSpacing: 10.w,
                      childAspectRatio: 2.4 / 3.2,
                    ),
                  ),
                );
              } else if (state is OrgPostLoaded && state.orgPosts.isEmpty) {
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

