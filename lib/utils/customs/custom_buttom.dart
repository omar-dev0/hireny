import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_colors.dart';
import 'package:hireny/utils/app_fonts.dart';

class CustomButtom extends StatelessWidget {
  String title;
  void Function()? onPressed;
  CustomButtom({super.key,required this.title,required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return             Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: SizedBox(
        width: double.infinity,
        height: 48.h,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor:  AppColors.primary  ,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),

            ),
          ),
          child:  Text( title,style: AppFonts.secMain.copyWith(color: AppColors.white),
          ),
        ),
      ),
    );
  }
}
