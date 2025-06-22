import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import '../../../../utils/constants/app_colors.dart';

class ExploreOrganizationCard extends StatelessWidget {
  final String size;
  final String companyName;
  final String logoImage;
  final String location;

  const ExploreOrganizationCard({
    Key? key,
    required this.size,
    required this.companyName,
    required this.logoImage,
    required this.location,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(12.w),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16.r),
        boxShadow: [
          BoxShadow(
            color: AppColors.grey.withOpacity(0.15),
            blurRadius: 8,
            offset: Offset(0, 4),
          )
        ],
        border: Border.all(color: AppColors.subPrimary2, width: 1),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          CircleAvatar(
            backgroundImage: AssetImage(logoImage),
            radius: 26.r,
          ),
          SizedBox(height: 10.h),
          Text(
            companyName,
            style: AppFonts.mainText.copyWith(fontSize: 16.sp),
            textAlign: TextAlign.center,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: 6.h),
          Container(
            padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
            decoration: BoxDecoration(
              color: AppColors.subPrimary.withOpacity(0.1),
              borderRadius: BorderRadius.circular(12.r),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.home_work_rounded, size: 14.sp, color: AppColors.grey),
                SizedBox(width: 4.w),
                Text(size, style: AppFonts.secMain.copyWith(fontSize: 12.sp)),
              ],
            ),
          ),
          SizedBox(height: 6.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.location_on, size: 14.sp, color: AppColors.grey),
              SizedBox(width: 4.w),
              Flexible(
                child: Text(
                  location,
                  style: AppFonts.secMain.copyWith(fontSize: 12.sp),
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
