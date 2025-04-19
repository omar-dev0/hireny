import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';


class popUpButtons extends StatelessWidget {
  const popUpButtons({
    super.key,required this.onPressed,
  });
  final void Function()? onPressed;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        TextButton(
          child: Text('Cancel'),
          onPressed: () => Navigator.of(context).pop(),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.primary,
          ),
          child: Text('Submit', style: TextStyle(color: AppColors.white)),
          onPressed: onPressed,
        ),
      ],
    );
  }
}
