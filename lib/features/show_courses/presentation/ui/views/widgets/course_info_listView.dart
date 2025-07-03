import 'package:flutter/material.dart';

import '../../../../../../utils/constants/app_colors.dart';
import '../../../../../../utils/constants/app_fonts.dart';

class CourseInfoListView extends StatelessWidget {
  const CourseInfoListView({super.key});

  @override
  Widget build(BuildContext context) {
    final controller = ScrollController();

    return Scrollbar(
      controller: controller,
      thumbVisibility: true,
      thickness: 8.0,
      radius: Radius.circular(10),
      child: Padding(
        padding: const EdgeInsets.only(bottom: 8.0),
        child: SizedBox(
          height: 180,
          child: ListView.builder(
            controller: controller,
            itemCount: 3,
            itemBuilder: (context, index) {
              return Row(
                children: [
                  Icon(Icons.arrow_right_outlined, color: AppColors.primary),
                  SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      "The course provides the entire toolbox you need to become a data scientist",
                      style: AppFonts.textFieldStyle,
                      softWrap: true,
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
