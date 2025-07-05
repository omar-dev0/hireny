import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/app_fonts.dart';
import 'custom_buttom.dart'; // Assuming you have this custom button widget

class DynamicBottomSheet extends StatefulWidget {
  final String title;
  final List<String> items;
  final Set<int> initialSelection;
  final Function(Set<int>) onSelectedIndicesChanged;

  const DynamicBottomSheet({
    Key? key,
    required this.title,
    required this.items,
    this.initialSelection = const {},
    required this.onSelectedIndicesChanged,
  }) : super(key: key);

  @override
  State<DynamicBottomSheet> createState() => _DynamicBottomSheetState();
}

class _DynamicBottomSheetState extends State<DynamicBottomSheet> {
  late Set<int> selectedIndices;

  @override
  void initState() {
    super.initState();
    selectedIndices = widget.initialSelection.toSet();
  }

  void _toggleSelection(int index, bool? isSelected) {
    setState(() {
      if (isSelected ?? false) {
        selectedIndices.add(index);
      } else {
        selectedIndices.remove(index);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16.w),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(30.r),
          topRight: Radius.circular(30.r),
        ),
      ),
      height: MediaQuery.of(context).size.height * 0.50,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          SizedBox(height: 15.h),
          Center(
            child: Container(
              height: 5.h,
              width: 134.w,
              decoration: BoxDecoration(
                color: AppColors.black,
                borderRadius: BorderRadius.all(Radius.circular(20.r)),
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
                onPressed: Navigator.of(context).pop,
                icon: Icon(Icons.close, size: 22.sp),
              ),
            ],
          ),
          SizedBox(height: 24.h),
          Expanded(
            child: ListView(
              children: widget.items.asMap().entries.map((entry) {
                int index = entry.key;
                String item = entry.value;

                return CheckboxListTile(
                  title: Text(item, style: AppFonts.secMain.copyWith(fontSize: 14.sp)),
                  value: selectedIndices.contains(index),
                  onChanged: (value) => _toggleSelection(index, value),
                  activeColor: AppColors.primary,
                  controlAffinity: ListTileControlAffinity.leading,
                );
              }).toList(),
            ),
          ),
          SizedBox(height: 16.h), // Add some space before the button
          CustomButtom(
            title: "Apply Filters",
            onPressed: () {
              widget.onSelectedIndicesChanged(selectedIndices); // Notify parent only when apply button is pressed
              Navigator.pop(context); // Close bottom sheet after applying filter
            },
          ),
          SizedBox(height: 16.h), // Add some space below the button
        ],
      ),
    );
  }
}


