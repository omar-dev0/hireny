import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class SizeBottomSheet extends StatefulWidget {
  const SizeBottomSheet({super.key});

  @override
  State<SizeBottomSheet> createState() => _SizeBottomSheetState();
}

class _SizeBottomSheetState extends State<SizeBottomSheet> {
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
                  _buildCheckboxListTile("0 - 100", context),
                  _buildCheckboxListTile("100 - 500", context),
                  _buildCheckboxListTile("500 - 1000", context),
                  _buildCheckboxListTile("1000 - 5000", context),
                  _buildCheckboxListTile("> 5000", context),
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
    List<String> categories = [
      "0 - 100",
      "100 - 500",
      "500 - 1000",
      "1000 - 5000",
      "> 5000",
    ];
    return categories.indexOf(title);
  }
}