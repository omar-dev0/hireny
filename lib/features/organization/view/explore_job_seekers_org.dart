import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/career_level_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/category_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/employment_status_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/gender_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/location_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/price_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/size_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/explore_job_seeker_card.dart';
import 'package:hireny/features/organization/view/widgets/explore_organization_card.dart';
import 'package:hireny/utils/constants/app_colors.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/constants/app_fonts.dart';
import '../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../utils/widgets/search_bar_widget.dart';
import 'explore_services_org.dart';

class ExploreJobSeekersOrg extends StatefulWidget {
  static String routeName = "ExploreJobSeekersOrg";

  const ExploreJobSeekersOrg({super.key});

  @override
  State<ExploreJobSeekersOrg> createState() => _ExploreJobSeekersOrgState();
}

class _ExploreJobSeekersOrgState extends State<ExploreJobSeekersOrg> {
  final List<String> chipLabels = [
    'Location',
    'Industry',
    'Career Level',
    'Employment Status',
    'Gender',
    'Age',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Function()?> onChipPressed = [
          () => showLocationSheet(context),
          () => showIndustrySheet(context),
          () => showCareerLevelSheet(context),
          () => showEmploymentStatusSheet(context),
          () => showGenderSheet(context),
          () => showAgeSheet(context),
    ];
    return Scaffold(
      backgroundColor: AppColors.subPrimary,
      body: Padding(
        padding:  EdgeInsets.symmetric(horizontal: 10.w,vertical: 15.h),
        child: CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child:     Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 20.h,),
                  SearchBarWidget(
                    firstSearchHint: "Enter service name",
                    secondSearchHint: "Job Seeker",
                    onSearchPressed: (){},
                  ),
                  SizedBox(height: 20.h,),
                  Text("Explore Job Seekers",style: AppFonts.mainText,),
                  Text("Discover courses to boost your skills and achieve your goals.",style: AppFonts.secMain,textAlign: TextAlign.center,),
                  SizedBox(height: 20.h,),
                  DynamicFilterChipsWidget(
                    chipLabels: chipLabels,
                    onChipPressed: onChipPressed,
                    onSelectionChanged: (Set<int> selectedIndices) {
                      print("Selected chips: $selectedIndices");
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Text("All Job Seekers (2310)",style: AppFonts.mainText,),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ExploreJobSeekerCard(
                      name: 'John',
                      logoImage: AppAssets.org_logo,
                      jobType: "Data Engineer",
                    ),
                    SizedBox(height: 15.h),
                  ],
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
showLocationSheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => LocationBottomSheet(),
  );
}
showIndustrySheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => CategoryBottomSheet(),
  );
}
showCareerLevelSheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => CareerLevelBottomSheet(),
  );
}
showEmploymentStatusSheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => EmploymentStatusSheet(),
  );
}
showGenderSheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => GenderBottomSheet(),
  );
}
showAgeSheet(context){
  return  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => PriceBottomSheet(),
  );
}
