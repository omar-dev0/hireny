import 'package:flutter/material.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

import '../../../domain/modules/seeker/seeker.dart';

class SideBar extends StatefulWidget {
  final int index;
  const SideBar({super.key, required this.index});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  late bool isSeeker;

  @override
  void initState() {
    super.initState();
    isSeeker = AppSharedData.user is Seeker;
    print('User type: ${AppSharedData.user.runtimeType}');
  }

  @override
  Widget build(BuildContext context) {
    final List<String> drawerList = isSeeker
        ? [
      "General Info",
      "Technical Info",
      "My Applications",
      "My Assessments",
      "My Calendar",
      "My Courses",
      "AI Tools",
    ]
        : [
      "General Info",
      "Org Representation",
      "Assessments",
      "My Service Requests",
      "Reviews",
      "Calendar",
    ];

    final List<String> routeList = isSeeker
        ? [
      PagesRoute.generalInfo,
      PagesRoute.techInfo,
      PagesRoute.myApplication,
      PagesRoute.myAssessment,
      PagesRoute.calender,
      PagesRoute.myCourses,
      // PagesRoute.aiTools, // ← Make sure this exists in routes
    ]
        : [
      PagesRoute.generalInfo,
      PagesRoute.orgRep,    // ← Must be added to your routes
      PagesRoute.myAssessment,         // Reuse if same as seeker
      PagesRoute.orgServiceRequest,    // ← Must be added
      PagesRoute.orgReviewForOrg,              // ← Must be added
      PagesRoute.calender,
    ];

    return Drawer(
      backgroundColor: AppColors.white,
      shape: const LinearBorder(),
      child: Column(
        children: [
          // Header
          Container(
            alignment: Alignment.center,
            width: double.infinity,
            height: MediaQuery.of(context).size.height * 0.25,
            color: AppColors.primary,
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: AssetImage(AppAssets.profileImg),
                  ),
                  const SizedBox(width: 16),
                  Flexible(
                    child: Text(
                      isSeeker ? "Seeker Name" : "Organization Name",
                      overflow: TextOverflow.ellipsis,
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: AppColors.white,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 20),

          // Home Shortcut
          InkWell(
            onTap: () {
              Navigator.pushReplacementNamed(context, PagesRoute.mainScreen);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: AppColors.primary, size: 35),
                const SizedBox(width: 10),
                Text(
                  "Back To Home",
                  style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                    color: AppColors.primary,
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 20),
          Divider(
            thickness: 3,
            color: AppColors.primary,
            endIndent: 30,
            indent: 30,
          ),

          // Drawer Items
          Expanded(
            child: ListView.builder(
              itemCount: drawerList.length,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    if (index < routeList.length) {
                      Navigator.pushReplacementNamed(
                          context, routeList[index]);
                    } else {
                      print('⚠️ No route defined for index $index');
                    }
                  },
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 16, vertical: 16),
                    child: Center(
                      child: Text(
                        drawerList[index],
                        style:
                        Theme.of(context).textTheme.headlineSmall!.copyWith(
                          color: AppColors.primary,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
