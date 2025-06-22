import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class EmploymentStatusSheet extends StatefulWidget {
  const EmploymentStatusSheet({super.key});

  @override
  State<EmploymentStatusSheet> createState() => _EmploymentStatusSheetState ();
}

class _EmploymentStatusSheetState extends State<EmploymentStatusSheet> {
  final Set<int> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.50,
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
                  "Select your category",
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
            Expanded(
              child: ListView(
                children: [
                  _buildCheckboxListTile("Employed", context),
                  _buildCheckboxListTile("Unemployed", context),
                  _buildCheckboxListTile("Freelancer", context),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildCheckboxListTile(String title, BuildContext context) {
    final index = getCategoryIndex(title);

    return CheckboxListTile(
      value: selectedCategories.contains(index),
      onChanged: (value) {
        setState(() {
          if (value == true) {
            selectedCategories.add(index);
          } else {
            selectedCategories.remove(index);
          }
        });
        print('Selected categories: $selectedCategories');
      },
      title: Text(title, style: AppFonts.secMain.copyWith(fontSize: 14.sp)),
      activeColor: AppColors.primary,
    );
  }

  int getCategoryIndex(String title) {
    List<String> Employment = [
      "Employed",
      "Unemployed",
      "Freelancer",
    ];
    return Employment.indexOf(title);
  }
}