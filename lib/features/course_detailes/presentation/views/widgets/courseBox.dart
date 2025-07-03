import 'package:flutter/material.dart';
import 'package:hireny/routes/page_route.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_buttom.dart';

class courseBox extends StatelessWidget {
  const courseBox({super.key, required this.course});

  final Map<String, dynamic> course;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Container(
        width: MediaQuery.of(context).size.width,
        height: 160,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16),
          color: AppColors.subPrimary,
          border: Border.all(color: AppColors.primary, width: 1),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24, top: 20, right: 8),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                course['name'],
                style: AppFonts.secMain.copyWith(
                  color: Colors.black,
                  fontWeight: FontWeight.w600,
                  fontSize: 20,
                ),
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
              ),
              SizedBox(height: 10),
              Text(
                "${course['sections']} Sections . ${course['hours']} hours",
                style: AppFonts.hintStyle,
              ),
              SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.check_circle, color: AppColors.primary),
                      SizedBox(width: 5),
                      Text("${course['level']}", style: AppFonts.hintStyle),
                    ],
                  ),
                  SizedBox(
                    height: 50,
                    width: 200,
                    child: Align(
                      alignment: Alignment.bottomRight,
                      child: CustomButtom(
                        title: "View Course",
                        onPressed: () {
                          Navigator.of(
                            context,
                          ).pushNamed(PagesRoute.courseDetails);
                        },
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
