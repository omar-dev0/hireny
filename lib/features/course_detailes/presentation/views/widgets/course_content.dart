import 'package:flutter/material.dart';
import '../../../../seeker/domain/modules/course.dart';

class CourseContentSection extends StatelessWidget {
  final Course? course;

  const CourseContentSection({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null || course!.lessons.isEmpty) {
      return const Center(child: Text("No lessons available for this course."));
    }

    // Dynamically build course content based on lessons
    final List<Map<String, dynamic>> courseContent = [];

    // Group all lessons under one chapter or split by section/chapter if needed
    courseContent.add({
      "chapter": "Course Content",
      "lessons":
          course!.lessons.map((lesson) {
            return {
              "title": lesson.title,
              "duration": _formatDuration(lesson.duration),
            };
          }).toList(),
    });

    return ListView.builder(
      itemCount: courseContent.length,
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final chapter = courseContent[index];
        return ExpansionTile(
          title: Text(
            chapter["chapter"],
            style: const TextStyle(fontWeight: FontWeight.bold),
          ),
          children: List.generate(chapter["lessons"].length, (i) {
            final lesson = chapter["lessons"][i];
            return ListTile(
              leading: Text('${i + 1}.'),
              title: Text(lesson["title"]),
              trailing: Text(lesson["duration"]),
            );
          }),
        );
      },
    );
  }

  String _formatDuration(Duration duration) {
    String twoDigits(int n) => n.toString().padLeft(2, '0');
    final hours = twoDigits(duration.inHours);
    final minutes = twoDigits(duration.inMinutes.remainder(60));
    final seconds = twoDigits(duration.inSeconds.remainder(60));
    return "$hours:$minutes:$seconds";
  }
}
