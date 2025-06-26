import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../features/seeker/domain/modules/course.dart';
import '../data_shared/app_shared_data.dart';

class CustomSearchBar extends StatelessWidget {
  final String hintText;
  final Function(String) onSearchChanged; // Changed from void to String

  const CustomSearchBar({
    Key? key,
    required this.hintText,
    required this.onSearchChanged,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20.h),
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15.r),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withOpacity(0.3),
            blurRadius: 10,
            offset: Offset(0, 4),
          ),
        ],
      ),
      child: TextField(
        onChanged: onSearchChanged, // Pass raw query to Cubit
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey.shade500),
          prefixIcon: Icon(
            Icons.search,
            color: AppColors.primary,
          ),
          border: InputBorder.none,
        ),
      ),
    );
  }
}