import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import 'course_info_listView.dart';


class ScrollContainer extends StatelessWidget {
  const ScrollContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.01),
              spreadRadius: 1,
              blurRadius: 4,
              offset: Offset(0, 4), // Bottom shadow
            ),
          ],
        ),
        child: CourseInfoListView()
    );
  }
}
