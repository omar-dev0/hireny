import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class DynamicFilterChipsWidget extends StatefulWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;
  final Function(Set<int>)? onSelectionChanged;
  final Set<int> selectedChipIndices;

  const DynamicFilterChipsWidget({
    Key? key,
    required this.chipLabels,
    required this.onChipPressed,
    this.onSelectionChanged,
    required this.selectedChipIndices,
  }) : super(key: key);

  @override
  _DynamicChipsWidgetState createState() => _DynamicChipsWidgetState();
}

class _DynamicChipsWidgetState extends State<DynamicFilterChipsWidget> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.chipLabels.length,
        itemBuilder: (BuildContext context, int index) {
          final isSelected = widget.selectedChipIndices.contains(index);
          return Padding(
            padding: EdgeInsets.symmetric(horizontal: 14.w),
            child: ChoiceChip(
              label: Text(
                widget.chipLabels[index],
                style: TextStyle(
                  color: AppColors.primary, // Always primary color
                ),
              ),
              selected: isSelected,
              selectedColor: AppColors.subPrimary2, // Keep selected color for background
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20.r), // Rounded corners
                side: BorderSide(color: AppColors.primary), // Border color
              ),
              onSelected: (bool selected) {
                // The selection logic is now handled by the parent widget
                if (widget.onChipPressed != null && widget.onChipPressed![index] != null) {
                  widget.onChipPressed![index]!();
                }
              },
            ),
          );
        },
      ),
    );
  }
}


