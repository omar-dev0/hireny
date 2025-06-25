import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import '../../../../../../utils/constants/app_colors.dart';
import 'bullet_point.dart';

class Requerment extends StatelessWidget {
  const Requerment({super.key});

  @override
  Widget build(BuildContext context) {
    final requirements = [
      'Education: Bachelor\'s degree in Business Administration, Marketing, or a related field.',
      'Experience: 3–5 years of experience in sales or account management, preferably in the corporate sector.',
      'Technical Skills: Proficiency in CRM tools and a good understanding of corporate solutions.',
      'Soft Skills: Strong communication, negotiation, and problem-solving abilities.',
      'Other: Proven track record of meeting or exceeding sales targets and KPIs.',
      'Language Skills: Proficiency in English; knowledge of additional languages is a plus.',
    ];

    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(requirements.length, (index) {
            return FadeInRight(
              delay: Duration(milliseconds: index * 100),
              child: BulletPoint(
                icon: CircleAvatar(
                  radius: 10,
                  backgroundColor: AppColors.primary,
                  child: Icon(Icons.check, color: Colors.white, size: 20),
                ),
                label: requirements[index],
              ),
            );
          }),
        ),
      ),
    );
  }
}
