import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/data_shared/shared_const_api.dart';
import '../../domain/modules/service.dart';

class ServiceCardOrgExplore extends StatelessWidget {
  final ServiceModel service;

  const ServiceCardOrgExplore({
    super.key,
    required this.service,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(16.r),
      margin: EdgeInsets.symmetric(vertical: 8.h),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12.r),
        border: Border.all(color: AppColors.subPrimary2.withOpacity(0.5)),
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
          // Company Logo + Name + Title
          Row(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8.r),
                child:
                Image.network(
                  '${ApiShared.baseUrl}${service.companyLogo}',
                  width: 60.w,
                  height: 60.h,
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) {
                    return Image.asset(AppAssets.org_logo, width: 60.w, height: 60.h);
                  },
                )
              ),
              SizedBox(width: 12.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      service.companyName ?? "Company Name",
                      style: AppFonts.mainText.copyWith(fontSize: 16.sp),
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                    ),
                    SizedBox(height: 4.h),
                    Text(
                      service.serviceTitle ?? "Service Title",
                      style: AppFonts.secMain.copyWith(fontSize: 14.sp),
                    ),
                  ],
                ),
              ),
            ],
          ),

          SizedBox(height: 16.h),

          // Description
          Text(
            service.serviceDescription ?? "",
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            style: AppFonts.textFieldStyle,
          ),

          SizedBox(height: 16.h),

          // Category Chips
          Wrap(
            spacing: 8.w,
            runSpacing: 4.h,
            children: service.category?.map((cat) {
              return Chip(
                label: Text(cat, style: AppFonts.textFieldStyle.copyWith(fontSize: 12.sp)),
                backgroundColor: AppColors.primary.withOpacity(0.1),
                padding: EdgeInsets.symmetric(horizontal: 6.w),
              );
            }).toList() ??
                [],
          ),

          SizedBox(height: 12.h),

          // Salary & Location
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "${service.salary} ${service.currency?.first ?? ""}",
                style: AppFonts.mainText.copyWith(fontWeight: FontWeight.bold),
              ),
              FittedBox(
                fit: BoxFit.scaleDown,
                child: Text(
                  "${service.country}, ${service.city}",
                  style: AppFonts.secMain.copyWith(fontSize: 14.cSp),
                ),
              )
            ],
          ),

          SizedBox(height: 12.h),

        ],
      ),
    );
  }
}