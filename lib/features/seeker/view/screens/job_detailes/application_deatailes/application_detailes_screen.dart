import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';

import '../../../../../../utils/constants/dialogs/error_dialog.dart';
import '../../../../../../utils/di/di.dart';
import '../../../../../auth/domain/modules/assessment/assessment.dart';
import 'application_detailes_content.dart';
import 'cubit/application_deatailes_cubit.dart';
import 'cubit/state/application_detailes_state.dart';

class ApplicationDetailesScreen extends StatefulWidget {
  final AssessmentModel? applicationModel;
  const ApplicationDetailesScreen({super.key, required this.applicationModel});

  @override
  State<ApplicationDetailesScreen> createState() =>
      _ApplicationDetailesScreenState();
}

class _ApplicationDetailesScreenState extends State<ApplicationDetailesScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ApplicationDeatailesCubit>(),
      child: BlocConsumer<ApplicationDeatailesCubit, ApplicationDetailesState>(
        builder:
            (context, state) => ApplicationDetailesContent(
              applicationModel: widget.applicationModel,
            ),
        listener: (context, state) {
          if (state is SubmitApplicationSuccess) {
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(
                    message: 'application submitted successfully',
                  ),
            );
            Navigator.pushNamedAndRemoveUntil(
              context,
              PagesRoute.firstPage,
              (_) => false,
            );
          }

          if (state is SubmitApplicationError) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'something went wrong'),
            );
          }
          if (state is HideSubmitApplicationLoading) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
