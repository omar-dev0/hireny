import 'package:flutter/material.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/about_course_tab.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_content_tap.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_header_section.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/reviews_tab.dart';

import '../../../../../utils/constants/app_colors.dart';


class courseScreenSeekerDetails extends StatelessWidget {
  const courseScreenSeekerDetails({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Header Section
                course_header_section(),
                // TabBar
                TabBar(
                  labelColor: AppColors.primary,
                  unselectedLabelColor: Colors.grey,
                  indicatorColor: AppColors.primary,
                  tabs: const [
                    Tab(text: "About Course"),
                    Tab(text: "Content"),
                    Tab(text: "Instructor"),
                    Tab(text: "Reviews"),
                  ],
                ),
                Expanded(
                  child: TabBarView(
                    children: [
                      AboutCourseTab(),
                      CourseContentTap(),
                      _instructorTab(),
                      ReviewsTab(),
                    ],
                  ),
                ),
                SizedBox(height: 20),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _instructorTab() {
    return Center(
      child: Text("Instructor information goes here"), // Customize as needed
    );
  }
}
