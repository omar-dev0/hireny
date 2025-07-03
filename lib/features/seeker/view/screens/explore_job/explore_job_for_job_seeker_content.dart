import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_search_bar.dart';
import '../../../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../../../utils/widgets/job_explore_card.dart';

import 'cubit/explore_job_cubit.dart';
import 'cubit/explore_job_states.dart';

class JobContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const JobContent({
    Key? key,
    required this.chipLabels,
    required this.onChipPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final cubit = BlocProvider.of<JobPostCubit>(context);

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
                    hintText: "Search for Jobs",
                    onSearchChanged: (value) {
                      // Trigger filtering in Cubit
                      context.read<JobPostCubit>().filterJobPosts(value);
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text("Job Search", style: AppFonts.mainText),
                  Text(
                    "Search for your desired job matching your skills.json",
                    style: AppFonts.secMain,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<JobPostCubit, JobPostState>(
                    builder: (context, state) {
                      Set<int> selectedChips = {};
                      // Determine which chips are 'selected' based on the cubit's filter state
                      if (cubit.selectedLocationIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Location'));
                      }
                      if (cubit.selectedCategoryIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Category'));
                      }
                      if (cubit.selectedJobTypeIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Job Type'));
                      }
                      if (cubit.selectedJobLocationIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Job Location'));
                      }
                      if (cubit.selectedExperienceLevelIndices.isNotEmpty) {
                        selectedChips.add(
                          chipLabels.indexOf('Experience Level'),
                        );
                      }
                      if (cubit.selectedDateFilter != 'All') {
                        selectedChips.add(chipLabels.indexOf('Date Posted'));
                      }
                      if (cubit.minSalaryFilter != null ||
                          cubit.maxSalaryFilter != null) {
                        selectedChips.add(chipLabels.indexOf('Salary'));
                      }

                      return DynamicFilterChipsWidget(
                        chipLabels: chipLabels,
                        onChipPressed: onChipPressed,
                        selectedChipIndices: selectedChips,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text("All Jobs", style: AppFonts.mainText),
                  SizedBox(height: 15.h),
                ],
              ),
            ),

            // Jobs List
            BlocBuilder<JobPostCubit, JobPostState>(
              builder: (context, state) {
                if (state is JobPostLoaded && state.jobPosts.isNotEmpty) {
                  return SliverList.builder(
                    itemCount: state.jobPosts.length,
                    itemBuilder: (context, index) {
                      final jobPost = state.jobPosts[index];
                      return Column(
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 300 + index * 100),
                            child: InkWell(
                              onTap: () {
                                Navigator.pushNamed(
                                  context,
                                  PagesRoute.jobDetailes,
                                  arguments: jobPost.id,
                                );
                              },
                              child: JobExploreCard(jobPost: jobPost),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    },
                  );
                } else if (state is JobPostLoaded && state.jobPosts.isEmpty) {
                  return SliverToBoxAdapter(
                    child: Center(
                      child: Text("No jobs found.", style: AppFonts.secMain),
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
