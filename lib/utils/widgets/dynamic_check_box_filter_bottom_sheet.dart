import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_colors.dart';
import '../constants/app_fonts.dart';

class DynamicBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;

  const DynamicBottomSheet({
    super.key,
    required this.title,
    required this.items,
  });

  @override
  State<DynamicBottomSheet> createState() => _DynamicBottomSheetState();
}

class _DynamicBottomSheetState extends State<DynamicBottomSheet> {
  final Set<int> selectedCategories = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30),
          topRight: Radius.circular(30),
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
                  widget.title,
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
                children: widget.items
                    .asMap()
                    .map((index, value) => MapEntry(
                  index,
                  CheckboxListTile(
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
                    title: Text(value,
                        style: AppFonts.secMain.copyWith(fontSize: 14.sp)),
                    activeColor: AppColors.primary,
                  ),
                ))
                    .values
                    .toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}