import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/app_assets.dart';
import '../../../../../utils/constants/app_colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key, required this.colored});

  final bool colored;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: colored ? AppColors.lightprimary : null,
      toolbarHeight: 40.h,
      flexibleSpace: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 35.h),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 20.0),
              child: Image.asset(AppAssets.logo, width: 110.w, height: 40.h),
            ),
            Row(
              children: [
                IconButton(
                  onPressed: () {},
                  icon: Icon(Icons.home),
                  color: AppColors.primary,
                ),
                IconButton(onPressed: () {}, icon: Icon(Icons.person)),
              ],
            ),
          ],
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(80.h); // very important!
}
