import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/courseBox.dart';

import '../../../../utils/constants/app_fonts.dart';
import '../manager/my_courses_cubit.dart';
import 'widgets/customAppBar.dart';


class MyCoursesView extends StatelessWidget {
  const MyCoursesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SideBar(),
      appBar: CustomAppBar(colored: false,),
      body: BlocBuilder<MyCoursesCubit, MyCoursesState>(
        builder: (context, state) {
          List<Map<String,dynamic>> courses=BlocProvider.of<MyCoursesCubit>(context).getMyCourses() ?? [];
          if(state is MyCoursesSuccess)
            {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("My Courses", style: AppFonts.mainText,),
                    SizedBox(height: 16,),
                    Expanded(
                        child: ListView.builder(
                            itemCount: courses.length,
                            itemBuilder: (context, index) {
                              return courseBox(course: courses[index],);
                            }
                        )
                    )
                  ],
                ),
              );
            }
          else
            {
              return Center(child: CircularProgressIndicator());
            }
        },
      ),

    );
  }
}
