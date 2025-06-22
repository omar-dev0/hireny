import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/category_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/price_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/explore_service_card.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/dymanic_filter_chips.dart';
import 'package:hireny/utils/widgets/search_bar_widget.dart';

class ExploreServicesOrg extends StatefulWidget {
  static String routeName = "ExploreServicesOrg";

   ExploreServicesOrg({super.key});

  @override
  State<ExploreServicesOrg> createState() => _ExploreServicesOrgState();
}

class _ExploreServicesOrgState extends State<ExploreServicesOrg> {
  final List<String> chipLabels = [
    'Category',
    'Price',
  ];



  @override
  Widget build(BuildContext context) {
    final List<Function()?> onChipPressed = [
          () => showCategorySheet(context),
          () => showPriceSheet(context),
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
                    secondSearchHint: "Company Name",
                    onSearchPressed: (){},
                  ),
                  SizedBox(height: 20.h,),
                  Text("Explore Services",style: AppFonts.mainText,),
                  Text("Discover Services to boost your company and achieve your goals.",style: AppFonts.secMain,textAlign: TextAlign.center,),
                  SizedBox(height: 20.h,),
                  DynamicFilterChipsWidget(
                    chipLabels: chipLabels,
                    onChipPressed: onChipPressed,
                    onSelectionChanged: (Set<int> selectedIndices) {
                      print("Selected chips: $selectedIndices");
                    },
                  ),
                  SizedBox(height: 20.h,),
                  Text("All Services (2310)",style: AppFonts.mainText,),
                ],
              ),
            ),
            SliverList.builder(
              itemCount: 10,
              itemBuilder: (context, index) {
                return Column(
                  children: [
                    ExploreServiceCard(
                      advertisingTitle: 'Advertising',
                      price: 'Free',
                      companyName: 'Google',
                      logoImage: AppAssets.org_logo,
                      requestsCount: '10+ requested',
                    ),
                    SizedBox(height: 15.h),
                  ],
                );
              },
            )
          ]

        ),
      ),
    );
  }
}
showCategorySheet(context){
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
showPriceSheet(context){
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