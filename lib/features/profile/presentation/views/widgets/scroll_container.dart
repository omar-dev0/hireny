import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import 'course_info_listView.dart';

class ScrollContainer extends StatelessWidget {
  final List<String> items;

  const ScrollContainer({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.05),
            spreadRadius: 1,
            blurRadius: 6,
            offset: Offset(0, 4),
          )
        ],
      ),
      child: CourseInfoListView(items: items),
    );
  }
}