import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../features/auth/domain/modules/seeker/seeker.dart';

class SideBarScreen extends StatelessWidget {
  final String currentRoute;
  const SideBarScreen({super.key, required this.currentRoute});

  bool get isSeeker => AppSharedData.user is Seeker;

  List<Map<String, dynamic>> get drawerItems => isSeeker
      ? [
    {
      "title": "General Info",
      "icon": Icons.info,
      "route": PagesRoute.generalInfo,
    },
    {
      "title": "Technical Info",
      "icon": Icons.computer,
      "route": PagesRoute.techInfo,
    },
    {
      "title": "My Applications",
      "icon": Icons.assignment_ind,
      "route": PagesRoute.myApplication,
    },
    {
      "title": "My Assessments",
      "icon": Icons.assessment,
      "route": PagesRoute.myAssessment,
    },
    {
      "title": "My Calendar",
      "icon": Icons.calendar_today,
      "route": PagesRoute.calender,
    },
    {
      "title": "My Courses",
      "icon": Icons.school,
      "route": PagesRoute.myCourses,
    },
    {
      "title": "AI Tools",
      "icon": Icons.smart_toy,
      "route": PagesRoute.aiTools,
    },
  ]
      : [
    {
      "title": "General Info",
      "icon": Icons.info,
      "route": PagesRoute.orgAccount,
    },
    {
      "title": "Representatives",
      "icon": Icons.apartment,
      "route": PagesRoute.orgRep,
    },
    {
      "title": "Assessments",
      "icon": Icons.assessment,
      "route": PagesRoute.orgAssessment,
    },
    {
      "title": "Service posts",
      "icon": Icons.post_add,
      "route": PagesRoute.orgServices,
    },
    {
      "title": "Service Requests",
      "icon": Icons.miscellaneous_services,
      "route": PagesRoute.orgServiceRequest,
    },
    {
      "title": "Calendar",
      "icon": Icons.calendar_today,
      "route": PagesRoute.calender,
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      child: Column(
        children: [
          /// ✅ Animated Header
          FadeInDown(
            duration: const Duration(milliseconds: 500),
            child: Container(
              width: double.infinity,
              color: AppColors.primary,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 25),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 30,
                    backgroundImage: AssetImage(AppAssets.profileImg),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Text(
                      isSeeker ? "${AppSharedData.user?.firstName} ${AppSharedData.user?.lastName}" : "${AppSharedData.user?.firstName}",
                      style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: 12),

          /// ✅ Animated Menu Items
          Expanded(
            child: ListView.separated(
              padding: const EdgeInsets.symmetric(horizontal: 8),
              itemCount: drawerItems.length,
              separatorBuilder: (_, __) =>
              const Divider(indent: 20, endIndent: 20),
              itemBuilder: (context, index) {
                final item = drawerItems[index];
                final bool isSelected = currentRoute == item['route'];

                return SlideInLeft(
                  duration: Duration(milliseconds: 300 + index * 100),
                  child: ListTile(
                    selected: isSelected,
                    selectedTileColor: AppColors.primary.withOpacity(0.1),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    leading: Icon(
                      item['icon'],
                      color: isSelected ? AppColors.primary : Colors.black54,
                    ),
                    title: Text(
                      item['title'],
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                    onTap: () {
                      if (!isSelected) {
                        Navigator.pushReplacementNamed(
                            context, item['route']);
                      } else {
                        Navigator.pop(context);
                      }
                    },
                  ),
                );
              },
            ),
          ),

          const Divider(indent: 20, endIndent: 20, height: 10),

          /// ✅ Footer (Back To Home)
          FadeInUp(
            duration: const Duration(milliseconds: 700),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                borderRadius: BorderRadius.circular(8),
                onTap: () {
                  Navigator.popAndPushNamed(context, PagesRoute.mainScreen);
                },
                child: Row(
                  children: [
                    Icon(Icons.exit_to_app,
                        color: AppColors.primary, size: 28),
                    const SizedBox(width: 10),
                    Text(
                      "Back To Home",
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
