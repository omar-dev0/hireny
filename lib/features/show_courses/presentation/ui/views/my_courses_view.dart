// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:hireny/core/widgets/sideBar.dart';
// import 'package:hireny/features/profile/presentation/manager/my_courses_cubit.dart';
// import 'package:hireny/features/profile/presentation/views/widgets/courseBox.dart';
// import 'package:hireny/routes/page_route.dart';
// import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
// import '../../../../utils/constants/app_fonts.dart';
//
// class MyCoursesView extends StatelessWidget {
//   const MyCoursesView({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return CustomScreen(
//       title: "My Courses",
//       drawer: SideBarScreen(currentRoute: PagesRoute.myCourses),
//       body: BlocBuilder<MyCoursesCubit, MyCoursesState>(
//         builder: (context, state) {
//           List<Map<String, dynamic>> courses =
//               BlocProvider.of<MyCoursesCubit>(context).getMyCourses() ?? [];
//           if (state is MyCoursesSuccess) {
//             return Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 24),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text("My Courses", style: AppFonts.mainText),
//                   SizedBox(height: 16),
//                   Expanded(
//                     child: ListView.builder(
//                       itemCount: courses.length,
//                       itemBuilder: (context, index) {
//                         return courseBox(course: courses[index]);
//                       },
//                     ),
//                   ),
//                 ],
//               ),
//             );
//           } else {
//             return Center(child: CircularProgressIndicator());
//           }
//         },
//       ),
//     );
//
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';

import 'package:hireny/core/widgets/sideBar.dart';

import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';

import '../../../../../utils/constants/app_fonts.dart';
import '../../../../course_detailes/presentation/views/widgets/courseBox.dart';
import '../manager/course_seeker_state.dart';
import '../manager/seeker_course_cubit.dart';

class MyCoursesView extends StatefulWidget {
  const MyCoursesView({super.key});

  @override
  State<MyCoursesView> createState() => _MyCoursesViewState();
}

class _MyCoursesViewState extends State<MyCoursesView> {
  @override
  void initState() {
    super.initState();
    context.read<SeekerCoursesCubit>().loadCourses();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "My Courses",
      drawer: SideBarScreen(currentRoute: PagesRoute.myCourses),
      body: BlocBuilder<SeekerCoursesCubit, SeekerCoursesSate>(
        builder: (context, state) {
          if (state is SuccessSeekerCourse) {
            final courses = context.read<SeekerCoursesCubit>().listCourses();

            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 16),

                  /// 📘 Title
                  FadeInDown(
                    duration: const Duration(milliseconds: 600),
                    child: Text(
                      "Registered Courses (${AppSharedData.registeredCourses.length})",
                      style: AppFonts.mainText,
                    ),
                  ),

                  const SizedBox(height: 12),

                  /// 📚 Course List
                  Expanded(
                    child: ListView.builder(
                      itemCount: AppSharedData.registeredCourses.length,
                      itemBuilder: (context, index) {
                        return FadeInUp(
                          duration: Duration(milliseconds: 400 + index * 100),
                          child: Padding(
                            padding: const EdgeInsets.only(bottom: 12.0),
                            child: courseBox(course: AppSharedData.registeredCourses[index]),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            );
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        },
      ),
    );
  }
}
