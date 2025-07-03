import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_fonts.dart';

class DateWidget extends StatelessWidget {
  final String? content;
  final String? label;
  const DateWidget({super.key, this.content, this.label});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label ?? "", style: AppFonts.mainText.copyWith(fontSize: 16.cSp)),
        SizedBox(height: 6.cSp),
        Container(
          width: double.infinity,
          padding: EdgeInsets.symmetric(horizontal: 10.w, vertical: 10.h),
          height: 50.h,
          decoration: BoxDecoration(
            color: AppColors.white,
            borderRadius: BorderRadius.circular(16),
            border: Border.all(color: AppColors.grey),
          ),
          child: Text(
            content ?? "",
            style: TextStyle(
              fontFamily: "Inter",
              fontSize: 16,
              color: AppColors.grey.withValues(alpha: 0.5),
              fontWeight: FontWeight.w400,
            ),
          ),
        ),
      ],
    );
  }
}
