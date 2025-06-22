import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class DynamicFilterChipsWidget extends StatefulWidget {
  final List<String> chipLabels;
  final List<Function()?> onChipPressed;
  final Function(Set<int>)? onSelectionChanged;

  const DynamicFilterChipsWidget({
    Key? key,
    required this.chipLabels,
    required this.onChipPressed,
    this.onSelectionChanged,
  }) : super(key: key);

  @override
  _DynamicChipsWidgetState createState() => _DynamicChipsWidgetState();
}

class _DynamicChipsWidgetState extends State<DynamicFilterChipsWidget> {
  Set<int> selectedChipIndices = {};

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.04,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: widget.chipLabels.length,
        itemBuilder: (BuildContext context, int index) {
          return Padding(
            padding:  EdgeInsets.symmetric(horizontal: 14.w),
            child: ChoiceChip(
              label: Text(
                widget.chipLabels[index],
                style: TextStyle(
                  color: selectedChipIndices.contains(index)
                      ? AppColors.primary // Selected color
                      : Colors.grey, // Unselected color
                ),
              ),
              selected: selectedChipIndices.contains(index),
              selectedColor: AppColors.subPrimary2,
              onSelected: (bool selected) {
                setState(() {
                  if (selected) {
                    selectedChipIndices.add(index);
                  } else {
                    selectedChipIndices.remove(index);
                  }
                });

                if (widget.onChipPressed != null && widget.onChipPressed![index] != null) {
                  widget.onChipPressed![index]!();
                }

                // Notify parent about selection changes
                if (widget.onSelectionChanged != null) {
                  widget.onSelectionChanged!(selectedChipIndices);
                }
              },
            ),
          );
        },
      ),
    );
  }
}