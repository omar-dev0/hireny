import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/cubit/salary_cubit.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/cubit/state/salary_state.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/salary_insights_screen_content.dart';
import 'package:hireny/features/seeker/view/screens/salary_insights/widgets/salary_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';

import '../../../../../utils/constants/dialogs/error_dialog.dart';

class SalaryInsightsScreen extends StatelessWidget {
  const SalaryInsightsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SalaryCubit, SalaryState>(
      builder: (context, state) {
        return SalaryInsightsScreenContent();
      },
      listener: (context, state) {
        SalaryCubit cubit = context.read<SalaryCubit>();
        if (state is LoadingSalary) {
          showDialog(context: context, builder: (_) => LoadingDialog());
        }
        if (state is FailSalary) {
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.error),
          );
        }
        if (state is SuccessSalary) {
          showDialog(
            context: context,
            builder:
                (_) => SalaryDialog(
                  message:
                      'avg Salary in ${cubit.location} in position ${cubit.jobTitle} is ${state.salary}\$',
                ),
          );
        }
        if (state is HideDialogSalary) {
          Navigator.pop(context);
        }
      },
    );
  }
}
