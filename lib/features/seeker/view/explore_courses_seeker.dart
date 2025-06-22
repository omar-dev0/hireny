import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/page_route.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_fonts.dart';
import '../../../utils/constants/helper_functions.dart';
import '../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../utils/widgets/explore_card.dart';
import '../../../utils/widgets/search_bar_widget.dart';

class ExploreCoursesSeeker extends StatefulWidget {
  static String routeName = "ExploreCoursesSeeker";

  const ExploreCoursesSeeker({super.key});

  @override
  State<ExploreCoursesSeeker> createState() => _ExploreCoursesSeekerState();
}

class _ExploreCoursesSeekerState extends State<ExploreCoursesSeeker> {
  final List<String> chipLabels = ['Industry', 'Date Published', 'Price'];

  @override
  Widget build(BuildContext context) {
    final List<Function()?> onChipPressed = [
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
        title: "Select Date Published",
        items: [
          "All",
          "Last Hour",
          "Last 24 Hours",
          "Last 7 Days",
          "Last 30 Days",
        ],
      ),
      () => showDynamicInputBottomSheet(
        context: context,
        title: "Select  Price Range",
        minHint: "Min Price",
        maxHint: "Max Price",
        buttonText: "Filter",
      ),
    ];
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
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
                    Text("All Courses (2310)", style: AppFonts.mainText),
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
                          Navigator.pushNamed(context, PagesRoute.courseDetails);
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
      ),
    );
  }
}
