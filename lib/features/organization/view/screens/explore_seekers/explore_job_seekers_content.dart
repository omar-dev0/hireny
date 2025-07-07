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
import '../../../../../routes/page_route.dart';
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
    final cubit = BlocProvider.of<ExploreSeekersCubit>(context);

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
                    hintText: "Seekers for Jobs",
                    onSearchChanged: (value) {
                      cubit.filterSeekers(value);
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text("Seekers Search", style: AppFonts.mainText),
                  Text(
                    "Search for your desired job matching your skills.",
                    style: AppFonts.secMain,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  BlocBuilder<ExploreSeekersCubit, SeekerPostState>(
                    builder: (context, state) {
                      Set<int> selectedChips = {};

                      if (cubit.selectedLocationIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Location'));
                      }
                      if (cubit.selectedIndustryIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Industry'));
                      }
                      // if (cubit.selectedCareerLevelIndices.isNotEmpty) {
                      //   selectedChips.add(chipLabels.indexOf('Career Level'));
                      // }
                      if (cubit.selectedEmploymentStatusIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Employment Status'));
                      }
                      if (cubit.selectedGenderIndices.isNotEmpty) {
                        selectedChips.add(chipLabels.indexOf('Gender'));
                      }
                      if (cubit.minAgeFilter != null || cubit.maxAgeFilter != null) {
                        selectedChips.add(chipLabels.indexOf('Age'));
                      }

                      return DynamicFilterChipsWidget(
                        chipLabels: chipLabels,
                        onChipPressed: onChipPressed,
                        selectedChipIndices: selectedChips,
                      );
                    },
                  ),
                  SizedBox(height: 24.h),
                  Text("All Seekers", style: AppFonts.mainText),
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
                                Navigator.pushNamed(
                                  context,
                                  PagesRoute.seekerDetailsOrg,
                                  arguments: seeker,
                                );
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
                      child: Text("No Seeker found.", style: AppFonts.secMain),
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