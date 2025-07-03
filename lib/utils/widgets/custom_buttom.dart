import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

class CustomButtom extends StatelessWidget {
  String title;
  double? hight;
  Color? color;
  void Function()? onPressed;
  CustomButtom({
    super.key,
    required this.title,
    required this.onPressed,
    this.hight,
    this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: hight ?? 48.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: color ?? AppColors.primary,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10.r),
            ),
          ),
          child: Text(
            title,
            style: AppFonts.secMain.copyWith(
              color:
                  color == Colors.white ? AppColors.primary : AppColors.white,
              fontSize: 16.cSp,
            ),
            textAlign: TextAlign.center,
          ),
        ),
      ),
    );
  }
}
