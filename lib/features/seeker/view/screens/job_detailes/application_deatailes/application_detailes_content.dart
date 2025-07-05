import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/check_box_q.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/qusituion.dart';
import 'package:hireny/features/my_assessment/presentation/ui/assissment_detailes/widgets/radio_question.dart';

import '../../../../../../utils/constants/app_fonts.dart';
import '../../../../../../utils/widgets/custom_buttom.dart';
import '../../../../../../utils/widgets/custom_text_field.dart';
import '../../../../../auth/domain/modules/assessment/assessment.dart';
import 'cubit/application_deatailes_cubit.dart';

class ApplicationDetailesContent extends StatefulWidget {
  final AssessmentModel? applicationModel;

  const ApplicationDetailesContent({super.key, required this.applicationModel});

  @override
  State<ApplicationDetailesContent> createState() =>
      _ApplicationDetailesContentState();
}

class _ApplicationDetailesContentState
    extends State<ApplicationDetailesContent> {
  @override
  Widget build(BuildContext context) {
    final ApplicationDeatailesCubit applicationCubit =
        context.read<ApplicationDeatailesCubit>();

    if (applicationCubit.totalQuestions == 0) {
      applicationCubit.totalQuestions =
          widget.applicationModel?.questions?.length ?? 0;
      applicationCubit.answaers = List.generate(
        applicationCubit.totalQuestions,
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
              /// Header: Title
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      widget.applicationModel?.assessmentTitle ?? "",
                      style: AppFonts.secMain.copyWith(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 20),

              /// Questions List
              Expanded(
                child: FadeInUp(
                  duration: const Duration(milliseconds: 500),
                  child: ListView.builder(
                    itemCount: applicationCubit.totalQuestions,
                    itemBuilder: (context, index) {
                      final question =
                          widget.applicationModel?.questions![index];
                      Widget? questionWidget;

                      if (question?.type == 'Text') {
                        questionWidget = CustomTextField(
                          onChange: (val) {
                            applicationCubit.answaers[index] = val;
                            return null;
                          },
                          maxLines: 8,
                          minLines: 1,
                        );
                      } else if (question?.type == 'Radio') {
                        questionWidget = ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: question?.choices?.length ?? 0,
                          itemBuilder:
                              (context, choiceIndex) => RadioQ(
                                index: choiceIndex,
                                selectedChoice:
                                    applicationCubit.answaers[index] as int?,
                                choice: question?.choices?[choiceIndex] ?? "",
                                onChanged: (value) {
                                  setState(() {
                                    applicationCubit.answaers[index] = value;
                                  });
                                },
                              ),
                        );
                      } else if (question?.type == 'Checkbox') {
                        questionWidget = StatefulBuilder(
                          builder: (context, setCheckboxState) {
                            List<int> selectedIndexes =
                                (applicationCubit.answaers[index]
                                    as List<int>?) ??
                                [];

                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: question?.choices?.length ?? 0,
                              itemBuilder: (context, choiceIndex) {
                                final isSelected = selectedIndexes.contains(
                                  choiceIndex,
                                );

                                return CheckBoxQ(
                                  choice: question?.choices?[choiceIndex] ?? "",
                                  isSelected: isSelected,
                                  onChanged: (value) {
                                    setCheckboxState(() {
                                      if (value == true) {
                                        selectedIndexes.add(choiceIndex);
                                      } else {
                                        selectedIndexes.remove(choiceIndex);
                                      }
                                      applicationCubit.answaers[index] =
                                          selectedIndexes;
                                    });
                                  },
                                );
                              },
                            );
                          },
                        );
                      }

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Qusituion(
                          question: 'Q${index + 1} : ${question?.text ?? ""}',
                          answer: questionWidget!,
                        ),
                      );
                    },
                  ),
                ),
              ),

              const SizedBox(height: 20),

              /// Submit Button
              CustomButtom(
                title: "Submit",
                onPressed: () {
                  applicationCubit.applyJob(
                    widget.applicationModel?.id ?? 0,
                    true,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
