import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/helper_functions.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import 'cubit/course_cubit.dart';
import 'cubit/course_states.dart';
import 'explore_course_screen_content.dart';

class ExploreCoursesSeeker extends StatefulWidget {
  static String routeName = "ExploreCoursesSeeker";

  ExploreCoursesSeeker({super.key});

  @override
  State<ExploreCoursesSeeker> createState() => _ExploreCoursesSeekerState();
}

class _ExploreCoursesSeekerState extends State<ExploreCoursesSeeker> {
  @override
  void initState() {
    super.initState();
    context.read<CourseCubit>().fetchNotRegisteredCourses();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CourseCubit, CourseState>(
      builder: (context, state) {
        if (state is CourseLoading) {
          return LoadingDialog();
        } else if (state is CourseError) {
          return ErrorDialog(message: state.message,);
        } else if (state is CourseLoaded) {
          return CourseContent(
            chipLabels: ["Category", "Date Published", "Price"],
            onChipPressed: [
                  () => _showCategoryBottomSheet(context),
                  () => _showDatePublishedBottomSheet(context),
                  () => _showPriceRangeBottomSheet(context),
            ],
          );
        } else {
          return const Scaffold(
            body: Center(
              child: Text("Initial State"),
            ),
          );
        }
      },
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: AppSharedData.industries,
      initialSelection: cubit.selectedCategoryIndices,
      onSelectedIndicesChanged: (indices) {
        cubit.updateCategoryFilter(indices);
      },
    );
  }

  void _showDatePublishedBottomSheet(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    showDynamicBottomSheet(
      context: context,
      title: "Select Date Published",
      items: ["All", "Last Hour", "Last 24 Hours", "Last 7 Days", "Last 30 Days"],
      initialSelection: {["All", "Last Hour", "Last 24 Hours", "Last 7 Days", "Last 30 Days"].indexOf(cubit.selectedDateFilter)},
      onSelectedIndicesChanged: (indices) {
        final List<String> allDates = ["All", "Last Hour", "Last 24 Hours", "Last 7 Days", "Last 30 Days"];
        final selectedDate = indices.isNotEmpty ? allDates[indices.first] : "All";
        cubit.updateDateFilter(selectedDate);
      },
    );
  }

  void _showPriceRangeBottomSheet(BuildContext context) {
    final cubit = context.read<CourseCubit>();
    showDynamicInputBottomSheet(
      context: context,
      title: "Select Price Range",
      minHint: "Min Price",
      maxHint: "Max Price",
      buttonText: "Filter",
      onpress: (min, max) {
        cubit.updatePriceRangeFilter(min: min, max: max);
      },
    );
  }
}


