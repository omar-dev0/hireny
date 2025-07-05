import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:hireny/features/seeker/domain/modules/course.dart';
import 'package:hireny/features/show_courses/presentation/ui/views/widgets/scroll_container.dart';

import '../../../../../utils/constants/app_fonts.dart';
import '../../../../profile/presentation/views/widgets/courseDescBox.dart';

class AboutCourseTab extends StatelessWidget {
  final Course? course;

  const AboutCourseTab({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    if (course == null) {
      return Center(child: Text("Course not found"));
    }

    List<String> learningOutcomes = _generateLearningOutcomes(course!.title, course!.description ?? "");
    List<String> requirements = _generateRequirements(course!.title, course!.description ?? "");

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

        const SizedBox(height: 30),
        FadeInLeft(
          duration: Duration(milliseconds: 600),
          child: Text("Requirements", style: AppFonts.mainText),
        ),
        const SizedBox(height: 20),
        SlideInUp(
          duration: Duration(milliseconds: 700),
          child: ScrollContainer(items: requirements),
        ),
      ],
    );
  }

  List<String> _generateLearningOutcomes(String title, String description) {
    final Map<List<String>, List<String>> templates = {
      ['python', 'programming', 'coding','cpp']: [
        "Master the fundamentals of Python programming",
        "Write clean and efficient code",
        "Understand data structures like lists, dictionaries, and tuples",
        "Build simple scripts and applications",
        "Work with external libraries and modules"
      ],
      ['banking', 'finance', 'accounting']: [
        "Understand core banking operations",
        "Learn about financial systems and transactions",
        "Explore different types of bank accounts",
        "Familiarize yourself with loan processing",
        "Gain insights into risk management in banking"
      ],
      ['design', 'ui', 'ux']: [
        "Learn the principles of visual design",
        "Create compelling layouts and interfaces",
        "Use design tools effectively",
        "Develop a professional design portfolio"
      ],
      ['data science', 'machine learning', 'ml', 'ai']: [
        "Understand the basics of data analysis",
        "Apply statistical methods to real-world datasets",
        "Build predictive models using machine learning algorithms",
        "Visualize and interpret results effectively"
      ],
    };

    for (var keywords in templates.keys) {
      if (_containsAny(title.toLowerCase(), keywords) || _containsAny(description.toLowerCase(), keywords)) {
        return templates[keywords]!;
      }
    }

    return [
      "Understand the basics of $title",
      "Apply key concepts in real-world scenarios",
      "Develop practical skills related to $title",
      "Enhance your knowledge through hands-on practice"
    ];
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