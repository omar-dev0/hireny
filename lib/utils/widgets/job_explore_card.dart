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
  final JobPost jobPost;

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
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 16.h),

          /// Job Type
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
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          SizedBox(height: 10.h),

          /// Salary
          Text(
            "Salary: ${jobPost.minSalary} ${jobPost.currency} - ${jobPost.maxSalary} ${jobPost.currency}",
            style: AppFonts.secMain.copyWith(color: AppColors.grey),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 10.h),

          /// Company Row
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Image.network(
                '${ApiShared.baseUrl}${jobPost.companyLogo}',
                width: 60.w,
                height: 60.w,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) {
                  return Image.asset(
                    AppAssets.org_logo,
                    width: 60.w,
                    height: 60.w,
                    fit: BoxFit.cover,
                  );
                },
              ),
              SizedBox(width: 8.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      jobPost.companyName,
                      style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
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
                        Expanded(
                          child: Text(
                            jobPost.country,
                            style: AppFonts.secMain.copyWith(color: AppColors.grey),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Total Applications
          Row(
            children: [
              Icon(Icons.people, size: 16.sp, color: AppColors.grey),
              SizedBox(width: 4.w),
              Text(
                jobPost.totalApplications.toString(),
                style: AppFonts.secMain.copyWith(color: AppColors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
          SizedBox(height: 10.h),

          /// Deadline
          Row(
            children: [
              Icon(Icons.calendar_today, size: 16.sp, color: AppColors.grey),
              SizedBox(width: 4.w),
              Text(
                "Deadline:",
                style: AppFonts.secMain.copyWith(color: AppColors.grey),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(width: 4.w),
              Expanded(
                child: Text(
                  formatDate(jobPost.deadline),
                  style: AppFonts.secMain.copyWith(color: AppColors.grey),
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
