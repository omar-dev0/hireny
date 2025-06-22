import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';

import '../constants/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  final VoidCallback onSearchPressed;
  final String firstSearchHint;
  final String secondSearchHint;

   SearchBarWidget({Key? key,required this.onSearchPressed, required this.firstSearchHint, required this.secondSearchHint}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: AppColors.subPrimary2),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.5),
            spreadRadius: 2,
            blurRadius: 5,
            offset: Offset(0, 3),)
        ]
      ),
      padding: EdgeInsets.all(16.r),
      child: Column(
        children: [
          CustomTextField(hint: firstSearchHint,),
          SizedBox(height: 12.h),
          CustomTextField(hint: secondSearchHint,),
          SizedBox(height: 16.h),
          CustomButtom(title: "Search", onPressed: (){})
        ],
      ),
    );
  }
}