// /features/course/presentation/ui/course_content.dart

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/explore_card.dart';
import 'package:hireny/utils/widgets/search_bar_widget.dart';

class CourseContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const CourseContent({
    super.key,
    required this.chipLabels,
    required this.onChipPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
      child: FadeIn(
        duration: Duration(milliseconds: 500),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h),
                  SearchBarWidget(
                    firstSearchHint: "Enter course name",
                    secondSearchHint: "Course category",
                    onSearchPressed: () {},
                  ),
                  SizedBox(height: 20.h),
                  Text("Explore Courses", style: AppFonts.mainText),
                  Text(
                    "Discover courses to boost your skills and achieve your goals.",
                    style: AppFonts.secMain,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  DynamicFilterChipsWidget(
                    chipLabels: chipLabels,
                    onChipPressed: onChipPressed,
                    onSelectionChanged: (Set<int> selectedIndices) {
                      print("Selected chips: $selectedIndices");
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text("All Courses", style: AppFonts.mainText),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    FadeInUp(
                      duration: Duration(milliseconds: 300 + index * 100),
                      child: InkWell(
                        onTap: () {
                          // Navigate to course details
                        },
                        child: ExploreCard(
                          title: 'Budgeting Made Simple',
                          price: 'Free',
                          name: 'Instructor name: John Smith',
                          logoImage: AppAssets.org_logo,
                          requestsCount: '10+ requested',
                        ),
                      ),
                    ),
                    SizedBox(height: 15.h),
                  ],
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}