import 'package:flutter/material.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';

import 'course_content.dart';



class CourseContentTap extends StatelessWidget {
  Course? course;
   CourseContentTap({required this.course,super.key});

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
            CourseContentSection(course : course),
          ],
        )
    );
  }
}