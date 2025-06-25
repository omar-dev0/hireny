import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class IconElement extends StatelessWidget {
  final Widget icon;
  final String label;
  const IconElement({super.key, required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        icon,
        SizedBox(width: 10.w),
        Text(
          overflow: TextOverflow.ellipsis,
          maxLines: 1,
          label,
          style: TextStyle(color: Colors.grey),
        ),
      ],
    );
  }
}
