import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/page_route.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_fonts.dart';
import '../../../../utils/constants/helper_functions.dart';
import '../../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../../utils/widgets/job_explore_card.dart';
import '../../../../utils/widgets/search_bar_widget.dart';

class ExploreJobSeeker extends StatefulWidget {
  static String routeName = "ExploreJobSeeker";

  const ExploreJobSeeker({super.key});

  @override
  State<ExploreJobSeeker> createState() => _ExploreJobSeekerState();
}

class _ExploreJobSeekerState extends State<ExploreJobSeeker> {
  final List<String> chipLabels = [
    'Location',
    'Category',
    'Job Type',
    'Job Location',
    'Experience Level',
    'Date Posted',
    'Salary',
  ];

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
            "Financial Services"
          ]),
          () => showDynamicBottomSheet(
          context: context,
          title: "Select Job Type",
          items: [
            "Full Time",
            "Part Time",
            "Freelance",
            "Seasonal",
            "Fixed-Price"
          ]),
          () => showDynamicBottomSheet(
          context: context,
          title: "Select Job Location",
          items: ["On-Site", "Remote", "Hybrid"]),
          () => showDynamicBottomSheet(
          context: context,
          title: "Select Experience Level",
          items: [
            "No-experience",
            "Fresher",
            "Intermediate",
            "Expert"
          ]),
          () => showDynamicBottomSheet(
          context: context,
          title: "Select Date Posted",
          items: [
            "All",
            "Last Hour",
            "Last 24 Hours",
            "Last 7 Days",
            "Last 30 Days"
          ]),
          () => showDynamicInputBottomSheet(
          context: context,
          title: "Select Salary Range",
          minHint: "Min Salary",
          maxHint: "Max Salary",
          buttonText: "Filter")
    ];

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: FadeInDown(
                duration: const Duration(milliseconds: 500),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 20.h),
                    SearchBarWidget(
                      firstSearchHint: "Enter Job title",
                      secondSearchHint: "Enter location",
                      onSearchPressed: () {},
                    ),
                    SizedBox(height: 20.h),
                    Text("Job Search", style: AppFonts.mainText),
                    Text(
                      "Search for your desired job matching your skills",
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
                    SizedBox(height: 20.h),
                    Text("All Jobs (2310)", style: AppFonts.mainText),
                    SizedBox(height: 20.h),
                  ],
                ),
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(bottom: 15.h),
                  child: FadeInUp(
                    duration:
                    Duration(milliseconds: 300 + index * 100), // Staggered
                    child: InkWell(
                      onTap: (){

                      },
                      child: JobExploreCard(
                        title: "Technical Support Specialist",
                        jobType: "PART-TIME",
                        salary: "20,000 EGP - 25,000 EGP",
                        companyName: "Google Inc.",
                        logoImage: AppAssets.org_logo,
                        location: "New Delhi, India",
                        applicantsCount: "10+ applicants",
                        deadline: "09/02/2025",
                      ),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
