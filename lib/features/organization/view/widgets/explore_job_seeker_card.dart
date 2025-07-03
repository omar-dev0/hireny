import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/domain/modules/seeker.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/data_shared/shared_const_api.dart';

class ExploreJobSeekerCard extends StatelessWidget {
  final SeekerModel seeker;

  const ExploreJobSeekerCard({
    required this.seeker,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(
          color: AppColors.subPrimary2.withOpacity(0.5),
          width: 1.0,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.shade200,
            blurRadius: 6.r,
            spreadRadius: 1.r,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Profile Header
          Row(
            children: [
              // Profile Image
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child: Image.network(
                  '${ApiShared.baseUrl}${seeker.photo}',
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(AppAssets.org_logo, width: 60.w, height: 60.h);
                  },
                ),
              ),
              SizedBox(width: 12.w),
              // Name and Title
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${seeker.user?.firstName ?? ""} ${seeker.user?.lastName ?? ""}",
                      style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Row(
                      children: [
                        Icon(Icons.work_outline, size: 16, color: AppColors.primary),
                        SizedBox(width: 4.w),
                        Expanded(
                          child: Text(
                            seeker.title ?? "No title",
                            style: AppFonts.secMain.copyWith(fontSize: 14.sp),
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

          SizedBox(height: 16.h),

          // Nationality
          Row(
            children: [
              Icon(Icons.location_on_outlined, size: 16, color: AppColors.primary),
              SizedBox(width: 6.w),
              Text("Nationality:", style: AppFonts.secMain),
              SizedBox(width: 4.w),
              Text(seeker.nationality ?? "Not specified", style: AppFonts.textFieldStyle),
            ],
          ),

          SizedBox(height: 8.h),

          // Career Level
          Row(
            children: [
              Icon(Icons.badge_outlined, size: 16, color: AppColors.primary),
              SizedBox(width: 6.w),
              Text("Career Level:", style: AppFonts.secMain),
              SizedBox(width: 4.w),
              Text(seeker.careerLevel ?? "Not specified", style: AppFonts.textFieldStyle),
            ],
          ),

          SizedBox(height: 8.h),

          // Location
          Row(
            children: [
              Icon(Icons.location_city, size: 16, color: AppColors.primary),
              SizedBox(width: 6.w),
              Text("Location:", style: AppFonts.secMain),
              SizedBox(width: 4.w),
              Text("${seeker.city}, ${seeker.country}".trim(),
                  style: AppFonts.textFieldStyle),
            ],
          ),

          SizedBox(height: 16.h),

          // Brief Summary or Skills (optional)
          if (seeker.skills != null && seeker.skills!.isNotEmpty)
            Wrap(
              spacing: 8.w,
              runSpacing: 4.h,
              children: seeker.skills!
                  .map((skill) => Chip(
                label: Text(skill.skillName ?? "",
                    style: AppFonts.textFieldStyle.copyWith(fontSize: 12.sp)),
                backgroundColor: AppColors.primary.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 6.w),
              ))
                  .take(3) // Show up to 3 skills
                  .toList(),
            ),

          SizedBox(height: 12.h),

        ],
      ),
    );
  }
}