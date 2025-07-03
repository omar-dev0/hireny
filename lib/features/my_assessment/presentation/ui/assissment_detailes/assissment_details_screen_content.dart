import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/check_box_q.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/qusituion.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/radio_question.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/timer.dart';
import '../../../../../utils/constants/app_fonts.dart';
import '../../../../../utils/widgets/custom_buttom.dart';
import '../../../../../utils/widgets/custom_text_field.dart';
import '../../../../auth/domain/modules/assessment/assessment.dart';
import 'cubit/assiss_cubit.dart';

class AssissmentDetailsScreenContent extends StatefulWidget {
  final AssessmentModel? assessmentModel;

  AssissmentDetailsScreenContent({super.key, required this.assessmentModel});

  @override
  State<AssissmentDetailsScreenContent> createState() =>
      _AssissmentDetailsScreenContentState();
}

class _AssissmentDetailsScreenContentState
    extends State<AssissmentDetailsScreenContent> {
  @override
  Widget build(BuildContext context) {
    final assissmentCubit = context.read<AssissmentCubit>();
    if (assissmentCubit.totalQuestions == 0) {
      assissmentCubit.totalQuestions =
          widget.assessmentModel?.questions?.length ?? 0;
      assissmentCubit.answaers = List.generate(
        assissmentCubit.totalQuestions,
        (index) => null,
      );
    }
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              /// Header: Title & Timer
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.assessmentModel?.assessmentTitle ?? "",
                      style: AppFonts.secMain.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.all(10),
                    child: CountdownTimer(
                      totalSeconds:
                          widget.assessmentModel!.assessmentDuration! * 60,
                      onTimeUp: () {
                        Future.delayed(Duration(seconds: 1), () {
                          Navigator.pop(context);
                          assissmentCubit.submitAssessment(
                            widget.assessmentModel?.id ?? -1,
                          );
                        });
                        assissmentCubit.onTimeFinished();
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Questions
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: PageView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    controller: assissmentCubit.pageController,
                    itemCount: assissmentCubit.totalQuestions,
                    onPageChanged: (index) {
                      assissmentCubit.currentPage = index;
                      setState(() {});
                    },
                    itemBuilder: (context, index) {
                      final question =
                          widget.assessmentModel?.questions![index];
                      Widget? questionWidget;

                      if (question?.type == 'Text') {
                        questionWidget = CustomTextField(
                          onChange: (val) {
                            assissmentCubit.answaers[index] = val;
                            return null;
                          },
                          maxLines: 8,
                          minLines: 1,
                        );
                      } else if (question?.type == 'Radio') {
                        questionWidget = ListView.builder(
                          itemCount: question?.choices?.length ?? 0,
                          itemBuilder:
                              (context, choiceIndex) => RadioQ(
                                index: choiceIndex,
                                selectedChoices:
                                    assissmentCubit.answaers[index],
                                choice: question?.choices?[choiceIndex] ?? "",
                                onChanged: (value) {
                                  assissmentCubit.answaers[index] = value;
                                },
                              ),
                        );
                      } else if (question?.type == 'Checkbox') {
                        questionWidget = ListView.builder(
                          itemCount: question?.choices?.length ?? 0,
                          itemBuilder: (context, choiceIndex) {
                            final List<bool> selectedChoices = List.filled(
                              question?.choices?.length ?? 0,
                              false,
                              growable: true,
                            );
                            return CheckBoxQ(
                              choice: question?.choices?[choiceIndex] ?? "",
                              isSelected: selectedChoices[choiceIndex],
                              onChanged: (value) {
                                if (assissmentCubit.answaers[index] == null) {
                                  assissmentCubit.answaers[index] = [];
                                  if (value == true) {
                                    assissmentCubit.answaers[index].add(
                                      choiceIndex,
                                    );
                                  }
                                } else {
                                  if (value == true) {
                                    assissmentCubit.answaers[index].add(
                                      choiceIndex,
                                    );
                                  }
                                  selectedChoices[choiceIndex] = value ?? false;
                                }
                              },
                            );
                          },
                        );
                      }

                      return Qusituion(
                        question: 'Q${index + 1} : ${question?.text ?? ""}',
                        answer: questionWidget!,
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Navigation Buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: CustomButtom(
                      title: 'Previous',
                      onPressed: () {
                        assissmentCubit.prev();
                      },
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: BlocBuilder<AssissmentCubit, dynamic>(
                      builder: (context, state) {
                        final isLastPage =
                            assissmentCubit.currentPage ==
                            assissmentCubit.totalQuestions - 1;
                        return CustomButtom(
                          title: isLastPage ? "Submit" : "Next",
                          onPressed: () {
                            if (isLastPage) {
                              assissmentCubit.submitAssessment(
                                widget.assessmentModel?.id ?? -1,
                              );
                            } else {
                              assissmentCubit.nexQuestion(
                                assissmentCubit.totalQuestions,
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
