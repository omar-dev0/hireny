import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/constants/app_colors.dart';
import '../constants/helper_functions.dart';
import '../data_shared/shared_const_api.dart';

class JobExploreCard extends StatelessWidget {
  JobPost jobPost;

  JobExploreCard({required this.jobPost});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 15.w, vertical: 16.h),
      decoration: BoxDecoration(
        color: AppColors.subPrimary,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.primary, width: 1.0),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            jobPost.jobTitle,
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
              jobPost.jobType.toUpperCase(),
              style: AppFonts.secMain.copyWith(
                fontSize: 12.sp,
                color: AppColors.white,
              ),
            ),
          ),
          SizedBox(height: 10.h),
          Text(
            "Salary: ${jobPost.minSalary} ${jobPost.currency} - ${jobPost.maxSalary} ${jobPost.currency}",
            style: AppFonts.secMain.copyWith(color: AppColors.grey),
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Image.network(
                '${ApiShared.baseUrl}${jobPost.companyLogo}',
                width: MediaQuery.sizeOf(context).width * .2,
                height: MediaQuery.sizeOf(context).height * .1,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    AppAssets.org_logo,
                  ); // Fallback to placeholder if image fails to load
                },
              ),
              SizedBox(width: 8.w),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    jobPost.companyName,
                    style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                  ),
                  SizedBox(height: 4.h),
                  Row(
                    children: [
                      Icon(
                        Icons.location_on,
                        size: 16.sp,
                        color: AppColors.grey,
                      ),
                      SizedBox(width: 4.w),
                      Text(
                        jobPost.country,
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
                jobPost.totalApplications.toString(),
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
                formatDate(jobPost.deadline), // <-- Format the date here

                style: AppFonts.secMain.copyWith(color: AppColors.grey),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
