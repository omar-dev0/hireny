import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class courseDescBox extends StatelessWidget {
  const courseDescBox({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.2,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        color: AppColors.subPrimary,
        border: Border.all(color: AppColors.subPrimary2, width: 1),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Course Description",
              style: AppFonts.mainText.copyWith(fontSize: 18),
            ),
            Expanded(
              child: ListView(
                children: [
                  SizedBox(height: 3),
                  Text(
                    "The Complete Data Science Bootcamp 2025 is a comprehensive,"
                    " beginner-to-advanced course designed to teach data science"
                    " fundamentals, machine learning, deep learning, "
                    "and data visualization. It covers tools like Python, R,"
                    " TensorFlow, and SQL while emphasizing hands-on projects."
                    " Ideal for aspiring data scientists, it helps build practical skills and"
                    " a strong portfolio for real-world applications.",
                    softWrap: true,
                    style: AppFonts.textFieldStyle,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
