import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/assissment_details_screen_content.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/assiss_cubit.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/cubit/state/assissment_states.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../auth/domain/modules/assessment/assessment.dart';

class AssissmentDetailsScreen extends StatelessWidget {
  final AssessmentModel? assessmentModel;
  const AssissmentDetailsScreen({super.key, required this.assessmentModel});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AssissmentCubit>(),
      child: BlocConsumer<AssissmentCubit, AssissmentState>(
        builder:
            (context, state) => AssissmentDetailsScreenContent(
              assessmentModel: assessmentModel,
            ),
        listener: (context, state) {
          if (state is SuccessSubmitAssessment) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pop(context);
              Navigator.pop(context);
              Navigator.pushReplacementNamed(context, PagesRoute.myAssessment);
            });
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(
                    message: 'Assessment submitted successfully',
                  ),
            );
          }

          if (state is ErrorSubmitAssessment) {
            showDialog(
              context: context,
              builder:
                  (_) => ErrorDialog(
                    message: 'some thing went wrong try to send it again',
                  ),
            );
          }
          if (state is HideLoadingSubmitAssessment) {
            Navigator.pop(context);
          }
          if (state is OnTimeFinished) {
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(
                    message: 'Time is up',
                    lottie: 'assets/animations/time.json',
                  ),
            );
          }

          if (state is LoadingSubmitAssessment) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }
        },
      ),
    );
  }
}
