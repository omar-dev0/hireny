import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/extensions/font_size.dart';

import '../constants/app_colors.dart';

class DropDownListCustom extends StatefulWidget {
  String hintText;
  IconData iconData;
  final List<String> items;

  DropDownListCustom({super.key,required this.hintText,required this.iconData,required this.items});

  @override
  State<DropDownListCustom> createState() => _DropDownListCustomState();
}

class _DropDownListCustomState extends State<DropDownListCustom> {
  String? value;

  @override
  Widget build(BuildContext context) {

    return  Padding(
      padding:  EdgeInsets.symmetric(horizontal: 16.w,vertical: 8.h),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.w),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.r),
          color: AppColors.subPrimary,
          border: Border.all(
            width: 1,
            color: AppColors.grey,
          ),
        ),
        child: Row(
          children: [
            Icon(
              widget.iconData, // Example prefix icon
              color: AppColors.grey,
              size: 24,
            ),
            SizedBox(width: 10),
            Expanded(
              child: DropdownButton<String>(
                onChanged: (text){
                  setState(() {
                    value = text;

                  });
                },
                value: value,
                dropdownColor: AppColors.white,
                hint: Text(widget.hintText),
                isExpanded: true,
                icon: Icon(Icons.keyboard_arrow_down),
                underline: SizedBox(),
                items: widget.items.map((item) { // Map the passed list to DropdownMenuItem
                  return DropdownMenuItem<String>(
                    value: item,
                    child: Text(
                      item,
                      style: TextStyle(fontSize: 18.cSp),
                    ),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
