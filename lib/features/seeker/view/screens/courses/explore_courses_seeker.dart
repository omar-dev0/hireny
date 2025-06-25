import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/cubit/course_cubit.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/helper_functions.dart';
import '../../cubit/course_states.dart';
import 'explore_course_screen_content.dart';

class ExploreCoursesSeeker extends StatelessWidget {
  static String routeName = "ExploreCoursesSeeker";

  ExploreCoursesSeeker({super.key});

  final CourseCubit courseCubit = getIt.get<CourseCubit>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => courseCubit..fetchNotRegisteredCourses(),
      child: BlocConsumer<CourseCubit, CourseState>(
        listener: (context, state) {
          if (state is CourseLoading) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }

          if (state is CourseError) {
            Navigator.pop(context); // Dismiss loading dialog if any
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: state.message),
            );
          }

          if (state is CourseLoaded) {
            // You can trigger any action here after load
            // e.g., show filter suggestion, etc.
          }
        },
        builder: (context, state) {
          if (state is CourseLoading) {
            return Center(child: CircularProgressIndicator());
          } else {
            return CourseContent(
              chipLabels: ['Industry', 'Date Published', 'Price'],
              onChipPressed: [
                () => _showCategoryBottomSheet(context),
                () => _showDatePublishedBottomSheet(context),
                () => _showPriceRangeBottomSheet(context),
              ],
            );
          }
        },
      ),
    );
  }

  void _showCategoryBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select your category",
      items: [
        "Commerce",
        "Telecommunications",
        "Hotels & Tourism",
        "Education",
        "Financial Services",
      ],
    );
  }

  void _showDatePublishedBottomSheet(BuildContext context) {
    showDynamicBottomSheet(
      context: context,
      title: "Select Date Published",
      items: [
        "All",
        "Last Hour",
        "Last 24 Hours",
        "Last 7 Days",
        "Last 30 Days",
      ],
    );
  }

  void _showPriceRangeBottomSheet(BuildContext context) {
    showDynamicInputBottomSheet(
      context: context,
      title: "Select Price Range",
      minHint: "Min Price",
      maxHint: "Max Price",
      buttonText: "Filter",
    );
  }
}
