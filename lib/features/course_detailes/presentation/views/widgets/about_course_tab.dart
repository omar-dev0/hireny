import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';

import '../../../../../utils/constants/app_fonts.dart';
import '../../../../profile/presentation/views/widgets/courseDescBox.dart';
import '../../../../show_courses/presentation/ui/views/widgets/scroll_container.dart';

class AboutCourseTab extends StatelessWidget {
  final Course? course;

  const AboutCourseTab({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return Center(child: Text("Course not found"));
    }

    List<String> learningOutcomes = _generateLearningOutcomes(course!.title, course!.description ?? "");

    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 20),
        FadeInDown(
          duration: Duration(milliseconds: 600),
          child: courseDescBox(desc: course!.description),
        ),
        const SizedBox(height: 25),

        FadeInLeft(
          duration: Duration(milliseconds: 600),
          child: Text("What you'll learn", style: AppFonts.mainText),
        ),
        const SizedBox(height: 20),
        SlideInUp(
          duration: Duration(milliseconds: 700),
          child: ScrollContainer(items: learningOutcomes),
        ),

        const SizedBox(height: 20),
      ],
    );
  }

  List<String> _generateLearningOutcomes(String title, String description) {
    return description.split(',');
  }

  List<String> _generateRequirements(String title, String description) {
    final Map<List<String>, List<String>> templates = {
      ['python', 'programming', 'coding','cpp']: [
        "Basic understanding of computer operations",
        "A laptop or desktop with internet access",
        "Willingness to learn programming concepts"
      ],
      ['banking', 'finance', 'accounting']: [
        "Interest in finance and banking systems",
        "Basic knowledge of economics (optional)",
        "Access to a device with internet connection"
      ],
      ['design', 'ui', 'ux']: [
        "A computer with design software installed",
        "Basic knowledge of design principles",
        "Creativity and attention to detail"
      ],
      ['data science', 'machine learning']: [
        "Basic math and statistics knowledge",
        "Familiarity with programming (preferably Python)",
        "Access to a modern computer and internet"
      ],
    };

    for (var keywords in templates.keys) {
      if (_containsAny(title.toLowerCase(), keywords) || _containsAny(description.toLowerCase(), keywords)) {
        return templates[keywords]!;
      }
    }

    return [
      "Passion for learning new skills",
      "Stable internet connection",
      "Dedicated time to complete the course"
    ];
  }

  bool _containsAny(String text, Iterable<String> keywords) {
    return keywords.any((word) => text.contains(word));
  }
}