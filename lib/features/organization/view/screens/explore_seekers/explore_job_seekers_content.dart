import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/explore_job_seeker_card.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_search_bar.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/explore_card.dart';
import 'cubit/explore_seekers_cubit.dart';
import 'cubit/explore_seekers_states.dart';

class ExploreJobSeekersContent extends StatelessWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;

  const ExploreJobSeekersContent({
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
                  CustomSearchBar(
                    hintText: "Search for Jobs",
                    onSearchChanged: (value) {
                      // Trigger filtering in Cubit
                      context.read<ExploreSeekersCubit>().filterSeekers(value);
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
                  DynamicFilterChipsWidget(
                    chipLabels: chipLabels,
                    onChipPressed: onChipPressed,
                    onSelectionChanged: (Set<int> selectedIndices) {
                      print("Selected chips: $selectedIndices");
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text("All Jobs", style: AppFonts.mainText),
                  SizedBox(height: 15.h),
                ],
              ),
            ),

            // Jobs List
            BlocBuilder<ExploreSeekersCubit, SeekerPostState>(
              builder: (context, state) {
                if (state is SeekerLoaded && state.seekers.isNotEmpty) {
                  return SliverList.builder(
                    itemCount: state.seekers.length,
                    itemBuilder: (context, index) {
                      final seeker = state.seekers[index];
                      return Column(
                        children: [
                          FadeInUp(
                            duration: Duration(milliseconds: 300 + index * 100),
                            child: InkWell(
                              onTap: () {
                                print("ttsssss");
                                // Navigator.pushNamed(
                                //   context,
                                //   PagesRoute.jobDetailes,
                                //   arguments: jobPost.id,
                                // );
                              },
                              child: ExploreJobSeekerCard(
                                seeker: seeker,

                              ),
                            ),
                          ),
                          SizedBox(height: 15.h),
                        ],
                      );
                    },
                  );
                } else if (state is SeekerLoaded && state.seekers.isEmpty) {
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