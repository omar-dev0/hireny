import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/course_details/review_cared_course.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../course_detailes/presentation/views/widgets/about_course_tab.dart';
import '../../../../course_detailes/presentation/views/widgets/course_content_tap.dart';
import '../../../../course_detailes/presentation/views/widgets/course_header_section.dart';
import '../../../domain/modules/course.dart';
import 'cubit/course_details_cubit.dart';

class CourseDeatailesContent extends StatelessWidget {
  final Course? course;
  const CourseDeatailesContent({super.key, this.course});

  @override
  Widget build(BuildContext context) {
    var cubit = context.read<CourseDetailsCubit>();
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              children: [
                // Header Section with course info
                course_header_section(course: course),

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
                      AboutCourseTab(course: course),
                      CourseContentTap(course: course),
                      instructorTab(course: course),
                      ReviwCardCourse(Id: course!.id, courseCubit: cubit),
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

  Widget instructorTab({required Course? course}) {
    if (course == null) {
      return Center(child: Text("Course not found"));
    }
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Instructor",
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          SizedBox(height: 10),
          Text("Name: ${course.instructorName}"),
          Text("Bio:  No bio available"),
        ],
      ),
    );
  }
}
