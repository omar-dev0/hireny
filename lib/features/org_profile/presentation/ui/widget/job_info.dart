import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';

class JobInfo extends StatelessWidget {
  final IconData icon;
  final String text;

  const JobInfo({required this.icon, required this.text});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: AppColors.primary),
        const SizedBox(width: 4),
        Text(text, style: TextStyle(color: AppColors.black)),
      ],
    );
  }
}
