import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import '../../../../utils/constants/app_colors.dart';

class ExploreServiceCard extends StatelessWidget {
  final String advertisingTitle;
  final String price;
  final String companyName;
  final String logoImage;
  final String requestsCount;


  const ExploreServiceCard({
    Key? key,
    required this.advertisingTitle,
    required this.price,
    required this.companyName,
    required this.logoImage,
    required this.requestsCount,
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
          Text(
            advertisingTitle,
            style: AppFonts.mainText
          ),
          SizedBox(height: 8.h),
          Text(
            'Price: $price',
            style: AppFonts.secMain
          ),
           SizedBox(height: 16.h),

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
            requestsCount,
            style: AppFonts.secMain
          ),
           SizedBox(height: 24.h),

          Row(
            children: [
              Expanded(child: CustomButtom(title: "View Details", onPressed: (){})),
               SizedBox(width: 16.w),
              Expanded(child: CustomButtom(title: "Request", onPressed: (){})),
            ],
          ),
        ],
      ),
    );
  }
}