import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';
import 'custom_buttom.dart';
import 'custom_text_field.dart';

class DynamicInputBottomSheet extends StatelessWidget {
  final String title;
  final String firstHint;
  final String secondHint;
  final String buttonText;
  final Function(String, String) onpress;

  const DynamicInputBottomSheet({
    super.key,
    required this.title,
    required this.firstHint,
    required this.secondHint,
    required this.buttonText,
    required this.onpress,
  });

  @override
  Widget build(BuildContext context) {
    final minController = TextEditingController();
    final maxController = TextEditingController();

    return Padding(
      padding: MediaQuery.of(context).viewInsets,
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
                  Text(title, style: AppFonts.secMain),
                  const Spacer(),
                  IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: Icon(Icons.close, size: 22.sp),
                  ),
                ],
              ),
              SizedBox(height: 24.h),
              CustomTextField(hint: firstHint, controller: minController),
              SizedBox(height: 10.h),
              CustomTextField(hint: secondHint, controller: maxController),
              SizedBox(height: 15.h),
              CustomButtom(
                title: buttonText,
                onPressed: () {
                  onpress(minController.text, maxController.text);
                  Navigator.pop(
                    context,
                  ); // Close bottom sheet after applying filter
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
