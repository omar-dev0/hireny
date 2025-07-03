import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/search_bar_widget.dart';

import '../../../utils/constants/helper_functions.dart';
import '../../../utils/widgets/custom_search_bar.dart';
import '../../../utils/widgets/explore_card.dart';

class ExploreServicesOrg extends StatefulWidget {
  static String routeName = "ExploreServicesOrg";

  ExploreServicesOrg({super.key});

  @override
  State<ExploreServicesOrg> createState() => _ExploreServicesOrgState();
}

class _ExploreServicesOrgState extends State<ExploreServicesOrg> {
  final List<String> chipLabels = [
    'Category',
    // 'Price',
  ];

  @override
  Widget build(BuildContext context) {
    final List<Function()?> onChipPressed = [
      () => showDynamicBottomSheet(
        context: context,
        title: "Select your category",
        onSelectedIndicesChanged: (selectedIndices) {},
        items: [
          "Commerce",
          "Telecommunications",
          "Hotels & Tourism",
          "Education",
          "Financial Services",
        ],
      ),
      // () => showDynamicInputBottomSheet(context: context,title: "Select  Price Range" , minHint: "Min Price", maxHint: "Max Price", buttonText: "Filter"),
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
                    hintText: "Search for service",
                    onSearchChanged: (value) {
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text("Explore Services", style: AppFonts.mainText),
                  Text(
                    "Discover Services to boost your company and achieve your goals.",
                    style: AppFonts.secMain,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20.h),
                  // DynamicFilterChipsWidget(
                  //   chipLabels: chipLabels,
                  //   onChipPressed: onChipPressed,
                  //   onSelectionChanged: (Set<int> selectedIndices) {
                  //     print("Selected chips: $selectedIndices");
                  //   },
                  // ),
                  SizedBox(height: 20.h),
                  Text("All Services (2310)", style: AppFonts.mainText),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    // ExploreCard(
                    //   title: 'Advertising',
                    //   price: 'Free',
                    //   name: 'Google',
                    //   logoImage: AppAssets.org_logo,
                    //   // requestsCount: '10+ requested',
                    // ),
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
