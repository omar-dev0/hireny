import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../utils/constants/app_colors.dart';
import '../../../../manage_org_account/reviews_tab/presentation/manager/review_cubit.dart';
import '../../../../manage_org_account/reviews_tab/presentation/manager/review_states.dart';

class ProgressIndicatorNumeric extends StatelessWidget {
  final int totalSteps;

  const ProgressIndicatorNumeric({super.key, required this.totalSteps});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context).textTheme;

    return BlocBuilder<ReviewCubit, ReviewStates>(
      builder: (context, state) {
        int currentStep = 1;
        if (state is StepChangedState) {
          currentStep = state.step;
        }

        List<int> displaySteps;
        if (totalSteps <= 5) {
          displaySteps = List.generate(totalSteps, (i) => i + 1);
        } else {
          displaySteps = [1, (totalSteps / 2).round(), totalSteps];
        }

        double progressValue = currentStep / totalSteps;

        return Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            children: [
              SizedBox(
                height: 60,
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.center,
                      child: Container(
                        height: 4,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                      ),
                    ),
                    Align(
                      alignment: Alignment.centerLeft,
                      child: FractionallySizedBox(
                        widthFactor: progressValue,
                        child: Container(
                          height: 4,
                          color: AppColors.primary,
                        ),
                      ),
                    ),
                    Align(
                      alignment: Alignment.center,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: displaySteps.map((step) {
                          bool isCurrent = step == currentStep;
                          return Container(
                            width: 30,
                            height: 30,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              color: isCurrent ? AppColors.primary : Colors.white,
                              border: Border.all(color: AppColors.primary),
                            ),
                            alignment: Alignment.center,
                            child: Text(
                              "$step",
                              style: TextStyle(
                                color: isCurrent ? Colors.white : Colors.black,
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          );
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
