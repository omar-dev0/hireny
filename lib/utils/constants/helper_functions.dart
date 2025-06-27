import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';

import '../../features/organization/view/widgets/bottomSheets/location_bottom_sheet.dart';
import '../widgets/dynamic_check_box_filter_bottom_sheet.dart';
import '../widgets/dynamic_input_bottom_sheet.dart';

void showDynamicBottomSheet({
  required BuildContext context,
  required String title,
  required List<String> items,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (context) => DynamicBottomSheet(
      title: title,
      items: items,
    ),
  );
}
void showDynamicInputBottomSheet({
  required BuildContext context,
  required String title,
  required String minHint,
  required String maxHint,
  required String buttonText,
}) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (context) => DynamicInputBottomSheet(
      title: title,
      firstHint: minHint,
      secondHint: maxHint,
      buttonText: buttonText,
    ),
  );
}
void showLocationSheet(context){
    showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(30.r),
        topRight: Radius.circular(30.r),
      ),
    ),
    builder: (_) => LocationBottomSheet(),
  );
}
String formatDate(String isoDate) {
  final date = DateTime.parse(isoDate);
  return '${DateFormat('MMM d, yyyy').format(date)}';
}