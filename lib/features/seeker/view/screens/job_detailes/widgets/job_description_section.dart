import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'bullet_point.dart';

class JobDesc extends StatelessWidget {
  final String description;

  const JobDesc({super.key, required this.description});
  @override
  Widget build(BuildContext context) {
    final bulletTexts = [
      'Build and maintain strong relationships with corporate clients to ensure their needs are effectively addressed.',
      'Provide innovative and customized solutions to enhance the efficiency of clients\' business operations.',
      'Analyze client requirements and propose tailored solutions that align with their goals and objectives.',
      'Enhance client satisfaction by delivering exceptional service and continuous support.',
      'Collaborate with internal teams to ensure seamless implementation of solutions.',
    ];

    return Padding(
      padding: EdgeInsets.all(20),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(bulletTexts.length, (index) {
            return FadeInUp(
              delay: Duration(milliseconds: 100 * index),
              child: BulletPoint(label: description),
            );
          }),
        ),
      ),
    );
  }
}
