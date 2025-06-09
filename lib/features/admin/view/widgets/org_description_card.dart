import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';

class OrganizationDescriptionCard extends StatelessWidget {
  const OrganizationDescriptionCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.subPrimary2,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Description",
            style: AppFonts.mainText.copyWith(color: AppColors.primary),
          ),
          Divider(color: AppColors.grey,height: 1,),
          Text(
            """
Corporate Solutions is a leading organization specializing in providing innovative business solutions to enterprises of all sizes. Our services include digital transformation, IT consulting, cloud solutions, and enterprise software development to help businesses optimize operations and drive growth. With a team of experts dedicated to delivering cutting-edge technology and strategic consulting, we empower organizations to stay ahead in a rapidly evolving market. At Corporate Solutions, we are committed to excellence, efficiency, and tailored solutions that meet the unique needs of our clients. 🚀
""",
            style: AppFonts.secMain.copyWith(color: AppColors.primary),
            textAlign: TextAlign.justify, //better readability
          ),
        ],
      ),
    );
  }
}