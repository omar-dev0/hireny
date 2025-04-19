import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/sectionHeader.dart';
import 'package:hireny/technical_info/presentation/widgets/skillBox.dart';

import '../../../utils/app_colors.dart';

class skillsSection extends StatelessWidget {
  const skillsSection({
    super.key, required this.title,
  });

  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        sectionHeader(title: title),
        SizedBox(height: 15,),
        Container(
            decoration: BoxDecoration(
                color: AppColors.lightGrey,
                borderRadius: BorderRadius.circular(14)
            ),
            height: 100,
            child:ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount:5,
                itemBuilder : (context,index)
                {
                  return skillBox();
                }
            )
        ),
      ],
    );
  }
}