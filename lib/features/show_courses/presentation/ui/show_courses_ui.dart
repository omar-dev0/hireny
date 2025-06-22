import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_courses/presentation/ui/manager/course_states.dart';
import '../../../../../../utils/constants/app_colors.dart';
import '../../../../utils/widgets/custom_appbar.dart';
import 'manager/course_cubit.dart';


class ShowCoursesUi extends StatefulWidget {
  const ShowCoursesUi({super.key});

  @override
  State<ShowCoursesUi> createState() => _ShowCoursesUiState();
}


class _ShowCoursesUiState extends State<ShowCoursesUi> {
  late CourseCubit cubit ;

  @override
  void initState() {
    super.initState();
    cubit = context.read<CourseCubit>();
    cubit.loadCourses();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: CustomAppbar(title: "View Courses",),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                  ),
                  onPressed: () {
                  },
                  child: Row(
                    children: [
                      Icon(Icons.add, color: AppColors.white, size: 20),
                      Text(
                        "Add new course",
                        style: Theme.of(context).textTheme.labelSmall!.copyWith(
                          color: AppColors.white,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: BlocBuilder<CourseCubit, CourseStates>(
                builder: (context, state) {
                  if (state is LoadingState) {
                    return Center(child: CircularProgressIndicator());
                  } else if (state is ErrorState) {
                    return Center(child: Text(state.message ?? "An error occurred"));
                  } else if (state is SuccessState) {
                    return cubit.courses.isEmpty?
                    Center(child: Text("You haven't added any courses yet  Tap the '+' button to begin",
                      style:Theme.of(context).textTheme.headlineSmall!.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500
                      ),textAlign: TextAlign.center,),)
                    :ListView.separated(
                      itemBuilder: (context, index) {
                        return Container(
                          width: double.infinity,
                          height: 100,
                          padding: const EdgeInsets.all(16.0),
                          decoration: BoxDecoration(
                            color: AppColors.subPrimary,
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: AppColors.primary, width: 2),
                          ),
                          child: Row(
                            children: [
                              Column(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Text(
                                        cubit.courses[index].courseName,
                                        style:
                                        Theme.of(context).textTheme.titleLarge,
                                      ),
                                      SizedBox(width: 16),
                                      Container(
                                        width: 100,
                                        height: 30,
                                        decoration: BoxDecoration(
                                          color: AppColors.primary,
                                          borderRadius: BorderRadius.circular(16),
                                        ),
                                        child: Center(
                                          child: Text(
                                            cubit.courses[index].courseType,
                                            style: Theme.of(context)
                                                .textTheme
                                                .labelSmall
                                                ?.copyWith(color: AppColors.white),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                  Text(
                                    cubit.courses[index].publishDate,
                                    style: Theme.of(context).textTheme.titleSmall
                                        ?.copyWith(color: AppColors.grey),
                                  ),
                                ],
                              ),
                              Spacer(),
                              InkWell(
                                onTap: () {
                                  // Navigate to the edit course screen
                                },
                                child: Icon(
                                  Icons.edit,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                              SizedBox(width: 8),
                              InkWell(
                                onTap: () {
                                  print(cubit.courses[index].courseType);
                                  cubit.deleteCourse(cubit.courses[index]);
                                },
                                child: Icon(
                                  Icons.delete,
                                  color: AppColors.primary,
                                  size: 30,
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                      separatorBuilder: (context, index) => SizedBox(height: 16),
                      itemCount: cubit.courses.length,
                    );
                  }
                  return Center(child: Text('No data available'));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
