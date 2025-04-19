import 'package:flutter/material.dart';

import '../../../utils/app_colors.dart';

class skillBox extends StatelessWidget {
  const skillBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8), // optional spacing
      child: Center( // 👈 this keeps the button at height 35
        child: Container(
          height: 40,
          width: 100,
          decoration: BoxDecoration(
              color: AppColors.primary,
              borderRadius: BorderRadius.circular(14)
          ),
          child: Center(
            child: Text(
              "Java",
              style: TextStyle(color: AppColors.white),
            ),
          ),
        ),
      ),
    );
  }
}


