import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';

class OrganizationInfoCard extends StatelessWidget {
  final String ceoName;
  final String size;
  final String industry;
  final String established_Year;
  final String Location;
  final String Phone;
  final String Email;

  const OrganizationInfoCard({
    super.key,
    required this.ceoName,
    required this.size,
    required this.industry,
    required this.established_Year,
    required this.Location,
    required this.Phone,
    required this.Email,
  }) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: AppColors.primary,
        borderRadius: BorderRadius.circular(10.r),
      ),
      padding: EdgeInsets.all(10.w),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Information",
            style: AppFonts.mainText.copyWith(color: AppColors.white),
          ),
          Divider(color: AppColors.grey,height: 1,),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "CEO : ",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              Text(
                ceoName,
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),

            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Size : ",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              Text(
                size,
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Industry : ",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              Text(
                industry,
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Established Year : ",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              Text(
                established_Year,
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Location : ",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              Text(
                Location,
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Phone : ",
                style: AppFonts.secMain.copyWith(color: Colors.white),
              ),
              Text(
                Phone,
                style: AppFonts.secMain.copyWith(color: Colors.white),
              ),
            ],
          ),
          SizedBox(height: 10.h,),
          Row(
            children: [
              Text(
                "Email",
                style: AppFonts.secMain.copyWith(color: AppColors.white),
              ),
              SizedBox(width: 10.w),
              Expanded(
                child: FittedBox(
                  fit: BoxFit.scaleDown,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    Email,
                    maxLines: 1,
                    style: AppFonts.secMain.copyWith(
                      color: Colors.blue,
                      decoration: TextDecoration.underline,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}