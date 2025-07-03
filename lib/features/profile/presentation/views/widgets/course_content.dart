import 'package:flutter/material.dart';

class CourseContentSection extends StatelessWidget {
  final List<Map<String, dynamic>> courseContent = [
    {
      "chapter": "Chapter 1 - Interacting to Code",
      "lessons": [
        {"title": "Introduction to Wireframing", "duration": "5 min"},
        {"title": "Creating Low Fidelity Prototypes", "duration": "6 min"},
        {"title": "Improve infrastructure", "duration": "6 min"},
      ],
    },
    {
      "chapter": "Chapter 2 - Introduction to Wireframing Design",
      "lessons": [
        {"title": "Wireframing Basics", "duration": "6 min"},
        {"title": "Designing this Design Methods", "duration": "5 min"},
        {"title": "Thinking and Wireframing", "duration": "6 min"},
      ],
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: courseContent.length,
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      itemBuilder: (context, index) {
        final chapter = courseContent[index];
        return ExpansionTile(
          title: Text(
            chapter["chapter"],
            style: TextStyle(fontWeight: FontWeight.bold),
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
}
