import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/app_colors.dart';
import 'package:hireny/utils/app_fonts.dart';

class CustomGetStarted extends StatelessWidget{
  const CustomGetStarted({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(6.r),
          ),
          border: Border.all(
            color: AppColors.primary
          )
        ),
        height: 30.h,
        child: ElevatedButton(
          onPressed: (){},
          style: ElevatedButton.styleFrom(
            backgroundColor:  AppColors.white  ,
            foregroundColor: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(6.r),

            ),
          ),
          child:  Text( "GetStarted",style: AppFonts.hintStyle.copyWith(color: AppColors.primary),
          ),
        ),
      ),
    );
  }
}
