import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/extensions/font_size.dart';

class ServiceDetailsDescription extends StatelessWidget {
  const ServiceDetailsDescription({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10.h),
      decoration: BoxDecoration(
        color: AppColors.subPrimary2,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(16.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Text(
                "Job Description",
                style: AppFonts.secMain.copyWith(color: AppColors.primary)
              ),
            ],
          ),
          SizedBox(height: 10.h),
          ..._buildDescriptionItems(),
        ],
      ),
    );
  }

  List<Widget> _buildDescriptionItems() {
    final descriptionPoints = [
      "Build and maintain strong relationships with corporate clients to ensure their needs are effectively addressed.",
      "Provide innovative and customized solutions to enhance the efficiency of clients' business operations.",
      "Analyze client requirements and propose tailored solutions that align with their goals and objectives.",
      "Enhance client satisfaction by delivering exceptional service and continuous support.",
      "Collaborate with internal teams to ensure seamless implementation of solutions.",
    ];

    return descriptionPoints.map((point) {
      return ListTile(
        contentPadding: EdgeInsets.zero,
        leading: Icon(
          Icons.circle,
          size: 10.w,
          color: AppColors.primary,
        ),
        title: Text(
          point,
          style: TextStyle(
            fontSize: 16.cSp,
            color: AppColors.primary,
          ),
        ),
      );
    }).toList();
  }
}