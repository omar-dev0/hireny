import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/assessment/presentation/manager/assessment_cubit.dart';
import 'package:hireny/features/assessment/presentation/ui/widgets/progress_indicator.dart';
import 'package:hireny/utils/constants/app_colors.dart';

class Assessment extends StatelessWidget {
  const Assessment({super.key});

  @override
  Widget build(BuildContext context) {
    final double height = MediaQuery.of(context).size.height;
    var theme = Theme.of(context).textTheme;
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            ProgressIndicatorNumeric(totalSteps: 20),
            SizedBox(height: height * 0.07),
            Center(
              child: Container(
                height: 350,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: AppColors.subPrimary,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(height: 20),
                      Text("Q1: What's your name?", style: theme.bodyLarge),
                      SizedBox(height: 40),
                      Text("a) John", style: theme.bodyLarge),
                      SizedBox(height: 20),
                      Text("b) Jackson", style: theme.bodyLarge),
                      SizedBox(height: 20),
                      Text("c) Wilson", style: theme.bodyLarge),
                      SizedBox(height: 20),
                      Text("d) Zotobia", style: theme.bodyLarge),
                      SizedBox(height: 20),
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(height: height * 0.1),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    context.read<AssessmentCubit>().goToPrevStep();
                  },
                  child: Text(
                    "Previous",
                    style: theme.bodySmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                  ),
                  onPressed: () {
                    // # of Questions
                    context.read<AssessmentCubit>().goToNextStep(20);
                  },
                  child: Text(
                    "Next",
                    style: theme.bodySmall?.copyWith(
                      color: AppColors.white,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
