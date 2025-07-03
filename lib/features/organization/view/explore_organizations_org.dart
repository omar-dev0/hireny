import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/view/widgets/bottomSheets/location_bottom_sheet.dart';
import 'package:hireny/features/organization/view/widgets/explore_organization_card.dart';
import 'package:hireny/utils/constants/app_colors.dart';

import '../../../utils/app_assets.dart';
import '../../../utils/constants/app_fonts.dart';
import '../../../utils/constants/helper_functions.dart';
import '../../../utils/widgets/custom_search_bar.dart';
import '../../../utils/widgets/dymanic_filter_chips.dart';
import '../../../utils/widgets/search_bar_widget.dart';
import '../../auth/domain/modules/user/user.dart';
import '../../seeker/domain/modules/org_post.dart';

class ExploreOrganizationsOrg extends StatefulWidget {
  static String routeName = "ExploreOrganizationsOrg";

  const ExploreOrganizationsOrg({super.key});

  @override
  State<ExploreOrganizationsOrg> createState() =>
      _ExploreOrganizationsOrgState();
}

class _ExploreOrganizationsOrgState extends State<ExploreOrganizationsOrg> {
  final List<String> chipLabels = ['Location', 'Industry', 'Size'];

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
        onSelectedIndicesChanged: (selectedIndices) {},
      ),
      () => showDynamicBottomSheet(
        context: context,
        title: "Select your Size",
        items: ["0 - 100", "100 - 500", "500 - 1000", "1000 - 5000", "> 5000"],
        onSelectedIndicesChanged: (selectedIndices) {},
      ),
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
                    hintText: "Search for organization",
                    onSearchChanged: (value) {
                    },
                  ),
                  SizedBox(height: 20.h),
                  Text("Explore Organizations", style: AppFonts.mainText),
                  Text(
                    "Discover courses to boost your skills.json and achieve your goals.",
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
                  Text("All Organizations (2310)", style: AppFonts.mainText),
                  SizedBox(height: 15.h),
                ],
              ),
            ),
            SliverPadding(
              padding: EdgeInsets.only(bottom: 20.h),
              sliver: SliverGrid(
                delegate: SliverChildBuilderDelegate((context, index) {
                  return InkWell(
                    onTap: () {
                      print('Tapped organization index $index');
                    },
                    child: ExploreOrganizationCard(
                      orgPost: OrgPost(
                        id: 5,
                        name: "Tech Solutions Inc.",
                        phone: "+201234567890",
                        country: "Egypt",
                        city: "Cairo",
                        ceoName: "Ahmed Ibrahim",
                        establishmentYear: 2010,
                        industry: "Information Technology",
                        organizationSize: "51-200",
                        updatesToEmail: true,
                        verificationStatus: true,
                        photo: AppAssets.org_logo,
                        createdAt: "2025-06-09T18:02:14.059188Z",
                        updatedAt: "2025-06-25T21:08:57.274667Z",
                        user: User.fromJson({
                          'id': 18,
                          'firstName': 'test',
                          'lastName': 'user',
                          'email': 'test@example.com',
                          'role': 'orgAdmin',
                        }),
                        proof: "/media/docs/proof.pdf",
                      ),
                    ),
                  );
                }, childCount: 10),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: 15.h,
                  crossAxisSpacing: 10.w,
                  childAspectRatio: 2 / 3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
