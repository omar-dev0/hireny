import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/about_course_tab.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_content_tap.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_header_section.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/reviews_tab.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';
import '../../../domain/modules/course.dart';
import 'cubit/course_details_cubit.dart';
import 'cubit/course_details_states.dart';

class courseScreenSeekerDetails extends StatelessWidget {
  final int courseId;

  const courseScreenSeekerDetails({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => getIt<CourseDetailsCubit>(),
      child: Builder(builder: (context) {
        // Fetch course details as soon as screen loads
        WidgetsBinding.instance.addPostFrameCallback((_) {
          context.read<CourseDetailsCubit>().fetchCourseDetails(courseId);
        });
        print(courseId);

        return DefaultTabController(
          length: 4,
          child: Scaffold(
            backgroundColor: Colors.white,
            body: SafeArea(
              child: BlocBuilder<CourseDetailsCubit, CourseDetailsState>(
                builder: (context, state) {
                  if (state is CourseDetailsLoading) {
                    return LoadingDialog();
                  } else if (state is CourseDetailsLoaded) {
                    final course = state.courseDetails;
                    return Padding(
                      padding: EdgeInsets.all(20),
                      child: Column(
                        children: [
                          // Header Section with course info
                          course_header_section(course: course,),

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
                                AboutCourseTab( course: course,),
                                CourseContentTap(course : course),
                                instructorTab(course : course),
                                ReviewsTab(),
                              ],
                            ),
                          ),

                          SizedBox(height: 20),
                        ],
                      ),
                    );
                  } else if (state is CourseDetailsError) {
                    return Center(
                      child: Text("Failed to load course: ${state.message}"),
                    );
                  }
                  return Container(); // fallback
                },
              ),
            ),
          ),
        );
      }),
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
  }}