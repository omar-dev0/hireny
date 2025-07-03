import 'package:flutter/material.dart';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:hireny/utils/constants/app_colors.dart';

import '../lang/lang.dart';

class CustomDropDown extends StatelessWidget {
  final List<String> items;
  final String? selectItem;
  final String? label;
  final void Function(String?) onChanged;

  const CustomDropDown({
    super.key,
    required this.items,
    this.selectItem,
    this.label,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      items: (filter, infiniteScrollProps) => items,
      selectedItem: selectItem,
      onChanged: onChanged,
      popupProps: PopupProps.menu(
        menuProps: MenuProps(backgroundColor: AppColors.white),
        showSearchBox: true,
        fit: FlexFit.loose,
        constraints: const BoxConstraints(maxHeight: 300),
      ),
      decoratorProps: DropDownDecoratorProps(
        decoration: InputDecoration(
          fillColor: AppColors.white,
          filled: true,
          labelText: label,
          labelStyle: const TextStyle(color: AppColors.grey),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(16),
            borderSide: BorderSide(
              color: AppColors.grey.withValues(alpha: 0.5),
            ),
          ),
        ),
      ),
    );
  }
}
