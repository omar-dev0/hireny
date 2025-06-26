import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/explore_organization_card.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../../../../../utils/app_assets.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../../utils/widgets/custom_search_bar.dart';
import '../../../../../utils/widgets/dymanic_filter_chips.dart';
import '../explore_job/cubit/explore_job_cubit.dart';

class ExploreOrgForSeeker extends StatefulWidget {
  static String routeName = "ExploreOrganizationsOrg";

  const ExploreOrgForSeeker({super.key});

  @override
  State<ExploreOrgForSeeker> createState() => _ExploreOrgForSeekerState();
}

class _ExploreOrgForSeekerState extends State<ExploreOrgForSeeker> {
  final List<String> chipLabels = ['Location', 'Industry', 'Size'];

  @override
  Widget build(BuildContext context) {
    final List<Function()?> onChipPressed = [
          () => showLocationSheet(context),
          () => showDynamicBottomSheet(
        context: context,
        title: "Select your category",
        items: [
          "Commerce",
          "Telecommunications",
          "Hotels & Tourism",
          "Education",
          "Financial Services",
        ],
      ),
          () => showDynamicBottomSheet(
        context: context,
        title: "Select your Size",
        items: ["0 - 100", "100 - 500", "500 - 1000", "1000 - 5000", "> 5000"],
      ),
    ];

    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  CustomSearchBar(
                    hintText: "Search for Jobs",
                    onSearchChanged: (value) {
                      context.read<JobPostCubit>().filterJobPosts(value);
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
                  FadeInLeft(
                    duration: Duration(milliseconds: 600),
                    child: DynamicFilterChipsWidget(
                      chipLabels: chipLabels,
                      onChipPressed: onChipPressed,
                      onSelectionChanged: (Set<int> selectedIndices) {
                        print("Selected chips: $selectedIndices");
                      },
                    ),
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
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20.h),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return FadeInUp(
                    delay: Duration(milliseconds: 100 * index),
                    duration: Duration(milliseconds: 500),
                    child: InkWell(
                      onTap: () {
                        print('Tapped organization index $index');
                      },
                      child: ExploreOrganizationCard(
                        companyName: 'Google',
                        logoImage: AppAssets.org_logo,
                        size: "Software",
                        location: "USA",
                      ),
                    ),
                  );
                }, childCount: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 10.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 2.6 / 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
