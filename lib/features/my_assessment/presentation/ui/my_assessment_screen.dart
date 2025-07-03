import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../utils/constants/dialogs/error_dialog.dart';
import '../cubit/states/user_assessments_states.dart';
import '../cubit/user_assessment_cubit.dart';
import 'my_assessment_content.dart';

class MyAssessmentScreen extends StatelessWidget {
  const MyAssessmentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<UserAssessmentCubit>()..getUserAssessments(),
      child: BlocConsumer<UserAssessmentCubit, UserAssessmentStates>(
        builder: (context, state) {
          if (state is LoadingAssessment) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is SuccessUserAssessments) {
            int missing =
                state.assessments
                    ?.where((e) => e.status?.toLowerCase() == 'missing')
                    .length ??
                0;
            int completed =
                state.assessments
                    ?.where((e) => e.status?.toLowerCase() == 'evaluated')
                    .length ??
                0;
            int pandding =
                state.assessments
                    ?.where((e) => e.status?.toLowerCase() == 'pending')
                    .length ??
                0;
            return MyAssessmentContent(
              assessments: state.assessments ?? [],
              missing: missing,
              completed: completed,
              pandding: pandding,
            );
          }
          return MyAssessmentContent(
            assessments: [],
            missing: 0,
            completed: 0,
            pandding: 0,
          );
        },
        listener: (context, state) {
          if (state is ErrorUserAssessments) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'Something went wrong'),
            );
          }
          if (state is HideLoadingAssessment) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
