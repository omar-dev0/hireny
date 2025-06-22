import 'package:flutter/material.dart';
import 'package:hireny/features/profile/presentation/views/widgets/about_course_tab.dart';
import 'package:hireny/features/profile/presentation/views/widgets/course_content_tap.dart';
import 'package:hireny/features/profile/presentation/views/widgets/course_header_section.dart';
import 'package:hireny/features/profile/presentation/views/widgets/reviews_tab.dart';
import '../../../../utils/constants/app_colors.dart';
import 'widgets/customAppBar.dart';

class CourseDetailsView extends StatelessWidget {
  const CourseDetailsView({super.key});

  @override
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        appBar: CustomAppBar(colored: true,),
        body: Column(
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
                  aboutCourseTab(),
                  course_content_tap(),
                  _instructorTab(),
                  reviewsTab(),
                ],
              ),
            ),
            SizedBox(height: 20,)
          ],
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