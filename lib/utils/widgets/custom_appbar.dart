import 'package:flutter/material.dart';

import '../constants/app_colors.dart';

class CustomAppbar extends StatelessWidget implements PreferredSizeWidget {
  final String title;

  const CustomAppbar({Key? key, required this.title}) : super(key: key);

  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);
  @override
  Widget build(BuildContext context) {
    return AppBar(
      title:Text(
        title,
        style: Theme.of(context).textTheme.headlineSmall!.copyWith(
          fontWeight: FontWeight.bold,
          color: AppColors.primary
        ),
      ),
      centerTitle: true,
      backgroundColor: AppColors.white,
      iconTheme: const IconThemeData(color: AppColors.primary),
    );
  }
}
