import 'package:flutter/material.dart';

import 'courseDescBox.dart';
import 'scroll_container.dart';
import '../../../../../utils/constants/app_fonts.dart';


class aboutCourseTab extends StatelessWidget {
  const aboutCourseTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding:  EdgeInsets.symmetric(horizontal: 10),
      children: [
        SizedBox(height: 20,),
        courseDescBox(),
        SizedBox(height: 25),
        Text("What you'll learn", style: AppFonts.mainText),
        SizedBox(height: 20),
        ScrollContainer(),
        SizedBox(height: 10),
        Text("Requirements", style: AppFonts.mainText),
        SizedBox(height: 20),
        ScrollContainer(),
        // Text("Course Content", style: AppFonts.mainText),
        // Add more course content details here
      ],
    );
  }
}


