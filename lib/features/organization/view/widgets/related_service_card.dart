import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

class ServiceCard extends StatelessWidget {
  const ServiceCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: EdgeInsets.symmetric(horizontal: 8.w, vertical: 4.h),
                decoration: BoxDecoration(
                  color: AppColors.subPrimary2,
                  borderRadius: BorderRadius.circular(5.r),
                ),
                child: Text(
                  "24 min ago",
                  style: TextStyle(fontSize: 12.sp, color: AppColors.primary),
                ),
              ),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            children: [
              Image.asset(AppAssets.org_logo, width: 40.w, height: 40.h),
              SizedBox(width: 10.w),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Internal Creative Coordinator",
                      style: AppFonts.secMain.copyWith(color: AppColors.black),
                    ),
                    SizedBox(height: 5.h),
                    Text("Green Group", style: AppFonts.hintStyle),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 15.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              ImageIcon(AssetImage(AppAssets.briefcase_logo)),
              Text("Commerce - Marketing"),
              ImageIcon(AssetImage(AppAssets.wallet_logo)),
              Text("40000 dollar"),
            ],
          ),
          SizedBox(height: 10.h),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ImageIcon(AssetImage(AppAssets.location_logo)),
              SizedBox(width: 10.w),
              Text("New-York, USA"),
            ],
          ),
          SizedBox(height: 15.h),
          CustomButtom(title: "Service Details", onPressed: () {}),
        ],
      ),
    );
  }
}
