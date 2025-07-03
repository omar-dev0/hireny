import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_search_bar.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/explore_card.dart';
import 'package:hireny/utils/widgets/search_bar_widget.dart';

import '../../../../../routes/page_route.dart';
import 'cubit/course_cubit.dart';
import 'cubit/course_states.dart';

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
    final cubit = BlocProvider.of<CourseCubit>(context);

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
                  CustomSearchBar(
                    hintText: "Search for Courses",
                    onSearchChanged: (value) {
                      cubit.filterCourses(value);
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text("Explore Courses", style: AppFonts.mainText),
                  Text(
                    "Discover courses to boost your skills.json and achieve your goals.",
                    style: AppFonts.secMain,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<CourseCubit, CourseState>(
                    builder: (context, state) {
                      // Determine which chips are 'selected' based on the cubit's filter state
                      Set<int> selectedChips = {};
                      if (cubit.selectedCategoryIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Category'));
                      }
                      if (cubit.selectedDateFilter != 'All') {
                        selectedChips.add(chipLabels.indexOf('Date Published'));
                      }
                      if (cubit.minPriceFilter != null ||
                          cubit.maxPriceFilter != null) {
                        selectedChips.add(chipLabels.indexOf('Price'));
                      }

                      return DynamicFilterChipsWidget(
                        chipLabels: chipLabels,
                        onChipPressed: onChipPressed,
                        selectedChipIndices: selectedChips,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text("All Courses", style: AppFonts.mainText),
                  SizedBox(height: 15.h),
                ],
              ),
            ),

            BlocBuilder<CourseCubit, CourseState>(
              builder: (context, state) {
                if (state is CourseLoaded && state.courses.isNotEmpty) {
                  return SliverList.builder(
                    itemCount: state.courses.length,
                    itemBuilder: (context, index) {
                      final course = state.courses[index];
                      return Column(
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 300 + index * 100),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PagesRoute.courseDetailes,
                                );
                              },
                              child: ExploreCard(
                                course: course,
                                logoImage: AppAssets.org_logo,
                                // requestsCount: "3",
                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    },
                  );
                } else if (state is CourseLoaded && state.courses.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("No courses found.", style: AppFonts.secMain),
                    ),
                  );
                } else {
                  return SliverToBoxAdapter(child: Container());
                }
              },
            ),
          ],
        ),
      ),
    );
  }
}
