import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/about_course_tab.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_content_tap.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/course_header_section.dart';
import 'package:hireny/features/course_detailes/presentation/views/widgets/reviews_tab.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/di/di.dart';
import '../../../../../utils/constants/dialogs/error_dialog.dart';
import '../../../../../utils/constants/dialogs/success_dialog.dart';
import '../../../../org_profile/presentation/manager/org_profile_states.dart';
import '../../../domain/modules/course.dart';
import 'course_deatailes_content.dart';
import 'cubit/course_details_cubit.dart';
import 'cubit/course_details_states.dart';

class courseScreenSeekerDetails extends StatelessWidget {
  final int courseId;

  const courseScreenSeekerDetails({super.key, required this.courseId});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) =>
              getIt<CourseDetailsCubit>()..fetchCourseDetails(courseId),
      child: BlocConsumer<CourseDetailsCubit, CourseDetailsState>(
        builder: (context, state) {
          var cubit = context.read<CourseDetailsCubit>();
          if (state is CourseDetailsLoading) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is CourseDetailsError) {
            return Scaffold(body: Center(child: Text(state.message)));
          }
          return CourseDeatailesContent(course: cubit.course);
        },
        listener: (context, state) {
          if (state is LoadingAddOrgReview) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }

          if (state is HideDialogCourseReview) {
            Navigator.pop(context);
          }

          if (state is ErrorAddCourseReview) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: state.error),
            );
          }

          if (state is SuccessAddCourseReview) {
            showDialog(
              context: context,
              builder: (_) => SuccessDialog(message: 'Success'),
            );
          }
        },
      ),
    );
  }
}
