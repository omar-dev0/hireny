import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/constants/app_colors.dart';

class ExploreCard extends StatelessWidget {
  final Course course;
  final String logoImage;
  // final String requestsCount;

  const ExploreCard({
    Key? key,
    required this.course,
    required this.logoImage,
    // required this.requestsCount,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(course.title, style: AppFonts.mainText),
          SizedBox(height: 8.h),
          Text('Price: ${course.price}', style: AppFonts.secMain),
          SizedBox(height: 16.h),

          Row(
            children: [
              Image.asset(logoImage, height: 32.h, width: 32.w),
              SizedBox(width: 8.w),
              Text(
                "Instructor: ${course.instructorName}",
                style: AppFonts.mainText.copyWith(fontSize: 15.sp),
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
            "Instructor: ${course.description}",
            style: AppFonts.secMain.copyWith(fontSize: 13.sp),
          ),
          SizedBox(height: 16.h),
          // Text(
          //     requestsCount,
          //     style: AppFonts.secMain
          // ),
        ],
      ),
    );
  }
}
