import 'package:flutter/material.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';

class CourseInfoListView extends StatelessWidget {
  final List<String> items;

  const CourseInfoListView({super.key, required this.items});

  @override
  Widget build(BuildContext context) {
    final ScrollController controller = ScrollController();

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
            itemCount: items.length,
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(vertical: 6.0, horizontal: 12.0),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(Icons.arrow_right_alt_outlined, color: AppColors.primary, size: 18),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        items[index],
                        style: AppFonts.textFieldStyle,
                        softWrap: true,
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}