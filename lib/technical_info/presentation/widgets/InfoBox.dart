import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/presentation/widgets/pop_up_form.dart';

import '../../../utils/constants/app_colors.dart';
import '../../../utils/constants/app_fonts.dart';
import '../../data/models/response/certificate_model.dart';
import '../../data/models/response/course_model.dart';
import '../../data/models/response/education_model.dart';
import '../../data/models/response/experience_model.dart';
import '../manager/technical_info_cubit.dart';


class InfoBox extends StatelessWidget {
  const InfoBox({
    super.key, required this.img, required this.info,
  });
  final String img;
  // final int id;
  final dynamic info;

  @override
  @override
  Widget build(BuildContext context) {
    String title = "";
    String organization = "";
    String startDate = "";
    String endDate = "";
    // String itemID = "";

    // Safely extract values based on the object type
    if (info is ExperienceModel) {
      title = info.jobTitle;
      organization = info.companyName;
      startDate = info.fromDate;
      endDate = info.toDate;
    } else if (info is Educations) {
      title = info.degree;
      organization = info.institutionName;
      startDate = info.fromDate;
      endDate = info.toDate;
    } else if (info is CourseModel) {
      title = info.courseName;
      organization = info.institutionName;
      startDate = info.dateCompleted;
      endDate = "";
    } else if (info is CertificateModel) {
      title = info.certificateName;
      organization = info.institutionName;
      startDate = info.dateIssued;
      endDate = "";
    } else {
      title = "Unknown";
      organization = "Unknown";
    }

    return Column(
      children: [
        SizedBox(height: 20),
        Container(
          decoration: BoxDecoration(
            color: AppColors.subPrimary.withOpacity(0.5),
            border: Border.all(color: AppColors.primary),
            borderRadius: BorderRadius.circular(12),
          ),
          height: 180,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Row(
              children: [
                Container(width: 65, height: 60, decoration: BoxDecoration(
                  border: Border.all(color: AppColors.primary),
                  borderRadius: BorderRadius.circular(16),
                  image: DecorationImage(image: AssetImage(img))
                ), ),
                SizedBox(width: 35),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: AppFonts.textFieldStyle.copyWith(fontSize: 20)),
                    SizedBox(height: 10),
                    Text(organization, style: AppFonts.secMain),
                    SizedBox(height: 5),
                    Row(
                      children: [
                        Text(
                          endDate.isNotEmpty ? "$startDate - $endDate" : startDate,
                          style: AppFonts.hintStyle.copyWith(fontSize: 16),
                        ),
                        SizedBox(width: 60),
                        IconButton(
                          onPressed: () {
                            final cubit = context.read<TechnicalInfoCubit>();

                            // Set values before showing the form
                            cubit.titleController.text = title;
                            cubit.institutionController.text = organization;
                            cubit.startDateController.text = startDate;
                            cubit.endDateController.text = endDate;
                            cubit.descriptionController.text = info.description ?? "";

                            // For experience job types and titles
                            if (info is ExperienceModel) {
                              cubit.selectedJobTitle = info.jobTitle;
                              cubit.selectedJobType = info.jobType;
                            }

                            // Set flags correctly for validation in update
                            cubit.setFormFlags(
                              certificate: info is CertificateModel,
                              course: info is CourseModel,
                              education: info is Educations,
                              experience: info is ExperienceModel,
                            );

                            // Now show the popup
                            popUpForm(context, () {
                              cubit.updateTechInfo(info.id.toString(), info);
                            }, title,updateFlag: true);
                          },
                          icon: Icon(Icons.edit),
                        ),
                        IconButton(
                          onPressed: () {
                            context.read<TechnicalInfoCubit>().deleteItem(info.id.toString(), info);

                          },
                          icon: Icon(Icons.delete),
                        ),
                      ],
                    ),
                  ],
                )
              ],
            ),
          ),
        )
      ],
    );
  }
}
