import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/constants/app_colors.dart';

class ExploreOrganizationCard extends StatelessWidget {
  final String size;
  final String companyName;
  final String logoImage;


  const ExploreOrganizationCard({
    Key? key,
    required this.size,
    required this.companyName,
    required this.logoImage,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding:  EdgeInsets.symmetric(horizontal: 15.w,vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(
          color: AppColors.subPrimary2,
          width: 1.0,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Image.asset(
                logoImage,
                height: 32.h,
                width: 32.w,
              ),
              SizedBox(width: 8.w),
              Text(
                  companyName,
                  style: AppFonts.mainText
              ),
            ],
          ),
          SizedBox(height: 16.h),
          Text(
              'Price: $size',
              style: AppFonts.secMain
          ),
           SizedBox(height: 24.h),
          CustomButtom(title: "View Page", onPressed: (){}),
        ],
      ),
    );
  }
}