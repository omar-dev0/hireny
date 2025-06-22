import 'package:flutter/material.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class SideBar extends StatefulWidget {
  final int index;
  const SideBar({super.key, required this.index});

  @override
  State<SideBar> createState() => _SideBarState();
}

class _SideBarState extends State<SideBar> {
  List<String> drawerList = [
    "General Info",
    "Technical Info",
    "My Applications",
    "My Assessments",
    "My Calendar",
    "My Courses",
    "AI Tools",
  ];

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: AppColors.white,
      shape: const LinearBorder(),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            width: MediaQuery.of(context).size.width,
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
                  Text(
                    "User's name",
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 20),
          InkWell(
            onTap: () {
              Navigator.pop(context);
            },
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.home, color: AppColors.primary, size: 35),
                const SizedBox(width: 10),
                GestureDetector(
                  onTap:
                      () => Navigator.pushReplacementNamed(
                        context,
                        PagesRoute.mainScreen,
                      ),
                  child: Text(
                    "Back To Home",
                    style: Theme.of(context).textTheme.headlineSmall!.copyWith(
                      color: AppColors.primary,
                      fontWeight: FontWeight.w500,
                    ),
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
                    Navigator.pop(context);
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 16,
                        ),
                        child: Text(
                          drawerList[index],
                          style: Theme.of(
                            context,
                          ).textTheme.headlineSmall!.copyWith(
                            color: AppColors.primary,
                            fontWeight:
                                widget.index == index
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                            decoration:
                                widget.index == index
                                    ? TextDecoration.underline
                                    : TextDecoration.none,
                            decorationColor: AppColors.primary,
                            decorationThickness: 2,
                          ),
                        ),
                      ),
                    ],
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
