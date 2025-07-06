import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/organization/domain/modules/organization.dart';
import 'package:hireny/features/seeker/domain/modules/org_post.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/data_shared/shared_const_api.dart';
import '../../../seeker/domain/modules/org_post.dart';

class ExploreOrganizationCardOrg extends StatelessWidget {
  final OrgPost orgPost;

  const ExploreOrganizationCardOrg({
    Key? key,
    required this.orgPost
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
          // CircleAvatar(
          //   backgroundImage: AssetImage(logoImage),
          //   radius: 26.r,
          // ),
          Image.network(
            '${ApiShared.baseUrl}${orgPost.photo}',
            width: MediaQuery.sizeOf(context).width * .2,
            height: MediaQuery.sizeOf(context).height * .1,
            fit: BoxFit.cover,
            errorBuilder: (_, __, ___) {
              return Image.asset(AppAssets.org_logo); // Fallback to placeholder if image fails to load
            },
          ),
          SizedBox(height: 10.h),
          Text(
            orgPost.name,
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
                Expanded(
                  child: Text(
                    orgPost.industry,
                    style: AppFonts.secMain.copyWith(fontSize: 12.sp),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                // FittedBox(
                //   fit: BoxFit.scaleDown,
                //     child: Text(orgPost.industry, style: AppFonts.secMain.copyWith(fontSize: 12.sp),maxLines: 2,
                //     )),
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
                  orgPost.country,
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
