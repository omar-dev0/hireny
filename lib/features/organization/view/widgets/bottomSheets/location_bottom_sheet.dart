import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/drop_down_list_custom.dart';

class LocationBottomSheet extends StatelessWidget {
  const LocationBottomSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:
          MediaQuery.of(context).viewInsets, // Adjust padding for the keyboard
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30.r),
            topRight: Radius.circular(30.r),
          ),
        ),
        height: MediaQuery.of(context).size.height * 0.40,
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
                  Text("Location", style: AppFonts.secMain),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 22.sp),
                  ),
                ],
              ),
              DropDownListCustom(
                iconData: Icons.location_city,
                hintText: "Choose country",
                items: ["Egypt", "Spain", "Argentina"],
              ),
              SizedBox(height: 8.h),
              DropDownListCustom(
                iconData: Icons.location_city,
                hintText: "Choose city",
                items: ["Cairo", "Giza", "Madrid"],
              ),
              SizedBox(height: 8.h),
              DropDownListCustom(
                iconData: Icons.location_city,
                hintText: "Choose area",
                items: ["Area1", "Area2", "Area3"],
              ),
            ],
          ),
        ),
      ),
    );
    ;
  }
}
