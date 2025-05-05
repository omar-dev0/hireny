import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';


class courseDescBox extends StatelessWidget {
  const courseDescBox({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width*0.2,
      height: 150,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 4,
            offset: Offset(0, 4), // Bottom shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("Course Description",style: AppFonts.mainText.copyWith(fontSize: 18),),
            Expanded(
              child: ListView(
                  children: [
                    SizedBox(height: 3,),
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
                  ]
              ),
            ),
          ],
        ),
      ),
    );
  }
}
