import 'package:flutter/material.dart';

import 'course_content.dart';



class course_content_tap extends StatelessWidget {
  const course_content_tap({super.key});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: EdgeInsets.all(16),
              child: Text("Course Content", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            ),
            CourseContentSection(),
          ],
        )
    );
  }
}