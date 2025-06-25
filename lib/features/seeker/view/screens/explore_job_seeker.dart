import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_fonts.dart';
import '../../../../utils/constants/helper_functions.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../../utils/widgets/job_explore_card.dart';
import '../../../../utils/widgets/search_bar_widget.dart';

class ExploreJobsForJobSeeker extends StatefulWidget {
  static String routeName = "ExploreJobSeeker";

  const ExploreJobsForJobSeeker({super.key});

  @override
  State<ExploreJobsForJobSeeker> createState() =>
      _ExploreJobsForJobSeekerState();
}

class _ExploreJobsForJobSeekerState extends State<ExploreJobsForJobSeeker> {
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
          "Financial Services",
        ],
      ),
      () => showDynamicBottomSheet(
        context: context,
        title: "Select Job Type",
        items: [
          "Full Time",
          "Part Time",
          "Freelance",
          "Seasonal",
          "Fixed-Price",
        ],
      ),
      () => showDynamicBottomSheet(
        context: context,
        title: "Select Job Location",
        items: ["On-Site", "Remote", "Hybrid"],
      ),
      () => showDynamicBottomSheet(
        context: context,
        title: "Select Experience Level",
        items: ["No-experience", "Fresher", "Intermediate", "Expert"],
      ),
      () => showDynamicBottomSheet(
        context: context,
        title: "Select Date Posted",
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
        title: "Select Salary Range",
        minHint: "Min Salary",
        maxHint: "Max Salary",
        buttonText: "Filter",
      ),
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
                    SizedBox(height: 20.h),
                    Container(
                      margin: EdgeInsets.symmetric(vertical: 20.h),
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(15.r),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.3),
                            blurRadius: 10,
                            offset: Offset(0, 4),
                          ),
                        ],
                      ),
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Search for jobs...',
                          hintStyle: TextStyle(color: Colors.grey.shade500),
                          prefixIcon: Icon(
                            Icons.search,
                            color: AppColors.primary,
                          ),
                          suffixIcon: IconButton(
                            onPressed: () {
                              showModalBottomSheet(
                                context: context,
                                backgroundColor: Colors.white,
                                builder: (_) => Padding(
                                  padding: EdgeInsets.all(20),
                                  child: Column(
                                    children: [
                                      Expanded(
                                        child: ListView.builder(
                                          itemCount: AppSharedData
                                              .countryCityData.keys.length,
                                          itemBuilder: (_, index) => InkWell(
                                            onTap: () {},
                                            child: Padding(
                                              padding: EdgeInsets.all(10),
                                              child: Text(
                                                AppSharedData.countryCityData.keys
                                                    .toList()[index],
                                                style: TextStyle(
                                                  color: AppColors.black,
                                                  fontSize: 16.cSp,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              );
                            },
                            icon: Icon(Icons.map, color: AppColors.primary),
                          ),
                          border: InputBorder.none,
                        ),
                        onChanged: (value) {
                          // Implement search logic here
                        },
                      ),
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
                    duration: Duration(
                      milliseconds: 300 + index * 100,
                    ), // Staggered
                    child: InkWell(
                      onTap: () {
                        Navigator.pushNamed(context,PagesRoute.jobDetailes);
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
