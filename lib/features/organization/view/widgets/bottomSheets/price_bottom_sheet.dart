import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class PriceBottomSheet extends StatelessWidget {
  const PriceBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: MediaQuery.of(context).viewInsets, // Adjust padding for the keyboard
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.45,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SizedBox(height: 15.h),
              Center(
                child: Container(
                  height: 5.h,
                  width: 134.w,
                  decoration: const BoxDecoration(
                    color: AppColors.black,
                    borderRadius: BorderRadius.all(Radius.circular(20)),
                  ),
                ),
              ),
              SizedBox(height: 8.h),
              Row(
                children: [
                  Text(
                    "Enter Min and Max price",
                    style: AppFonts.secMain,
                  ),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 22.sp),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomTextField(hint: "Min price",),
              SizedBox(height: 10.h),
              CustomTextField(hint: "Max price",),
              SizedBox(height: 15.h),
              CustomButtom(title: "Filter", onPressed: (){})
      
            ],
          ),
        ),
      ),
    );;
  }
}
