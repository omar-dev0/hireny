import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/constants/app_colors.dart';

class JobExploreCard extends StatelessWidget {
  final String title;
  final String jobType;
  final String salary;
  final String companyName;
  final String logoImage;
  final String location;
  final String applicantsCount;
  final String deadline;

  const JobExploreCard({
    Key? key,
    required this.title,
    required this.jobType,
    required this.salary,
    required this.companyName,
    required this.logoImage,
    required this.location,
    required this.applicantsCount,
    required this.deadline,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.primary,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: AppFonts.mainText.copyWith(fontSize: 18.sp),
          ),
          SizedBox(height: 16.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(4.r),
            ),
            child: Text(
              jobType.toUpperCase(),
              style: AppFonts.secMain.copyWith(
                fontSize: 12.sp,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Salary: $salary",
            style: AppFonts.secMain.copyWith(color: AppColors.grey),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Image.asset(
                AppAssets.org_logo,
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    companyName,
                    style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(Icons.location_on, size: 16.sp, color: AppColors.grey),
                      SizedBox(width: 4.w),
                      Text(
                        location,
                        style: AppFonts.secMain.copyWith(color: AppColors.grey),
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.people, size: 16.sp, color: AppColors.grey),
              SizedBox(width: 4.w),
              Text(
                applicantsCount,
                style: AppFonts.secMain.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: AppColors.grey),
              SizedBox(width: 4.w),
              Text(
                "Deadline:",
                style: AppFonts.secMain.copyWith(color: AppColors.grey),
              ),
              SizedBox(width: 4.w),
              Text(
                deadline,
                style: AppFonts.secMain.copyWith(color: AppColors.grey),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Expanded(
                child: CustomButtom(title: "View details", onPressed: (){}),
              ),
              SizedBox(width: 16.w),
              Expanded(
                child: CustomButtom(title: "Apply now", onPressed: (){}),
              ),
            ],
          ),
        ],
      ),
    );
  }
}