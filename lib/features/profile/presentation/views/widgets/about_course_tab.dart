import 'package:flutter/material.dart';
import 'package:animate_do/animate_do.dart';

import 'courseDescBox.dart';
import 'scroll_container.dart';
import '../../../../../utils/constants/app_fonts.dart';

class AboutCourseTab extends StatelessWidget {
  const AboutCourseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.symmetric(horizontal: 10),
      children: [
        const SizedBox(height: 20),

        FadeInDown(
          duration: Duration(milliseconds: 600),
          child: courseDescBox(),
        ),

        const SizedBox(height: 25),

        FadeInLeft(
          duration: Duration(milliseconds: 600),
          child: Text("What you'll learn", style: AppFonts.mainText),
        ),

        const SizedBox(height: 20),

        SlideInUp(
          duration: Duration(milliseconds: 700),
          child: ScrollContainer(),
        ),

        const SizedBox(height: 10),

        FadeInLeft(
          duration: Duration(milliseconds: 600),
          child: Text("Requirements", style: AppFonts.mainText),
        ),

        const SizedBox(height: 20),

        SlideInUp(
          duration: Duration(milliseconds: 700),
          child: ScrollContainer(),
        ),
      ],
    );
  }
}
