import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/constants/helper_functions.dart';
import '../../../../seeker/domain/modules/course.dart';


class course_header_section extends StatelessWidget {
  Course? course;
   course_header_section({
     required this.course,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          height: 160,
          decoration: BoxDecoration(
            color: AppColors.white,
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 4,
                offset: Offset(0, 4), )// Bottom shadow
            ],
            borderRadius: BorderRadius.only(
              bottomRight: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
          ),

        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 20),
              Text(
                course?.title ?? 'Course Title',
                style: AppFonts.mainText,
                maxLines: 2,
              ),
              const SizedBox(height: 6),
              Text.rich(
                TextSpan(
                  children: [
                    TextSpan(
                      text: 'Created by ',
                      style: AppFonts.secMain.copyWith(fontSize: 15),
                    ),
                    TextSpan(
                      text: course?.instructorName ?? 'Instructor Name',
                      style: AppFonts.secMain.copyWith(
                          fontSize: 15, color: AppColors.primary),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 6),
              Text(
                formatDate( course!.updatedAt) ?? 'Date' ,
                style: AppFonts.secMain.copyWith(fontSize: 15),
              ),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ],
    );
  }
}