import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/data/models/response/certificate_model.dart';
import 'package:hireny/technical_info/data/models/response/course_model.dart';
import 'package:hireny/technical_info/data/models/response/education_model.dart';
import 'package:hireny/technical_info/data/models/response/experience_model.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

class FormAddInfo extends StatelessWidget {
  final dynamic type;
  final String title;
  const FormAddInfo({super.key, this.type, required this.title});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TechnicalInfoCubit>();
    final String cleanTitle = title.replaceFirst("My ", "").trim().toLowerCase();

    final bool isExperience = cleanTitle == "experience";
    final bool isEducation = cleanTitle == "education";
    final bool isCourse = cleanTitle == "courses";
    final bool isCertificate = cleanTitle == "certificate" || cleanTitle == "certificates";

    debugPrint('Title: $title');
    debugPrint('isExperience: $isExperience');
    debugPrint('isEducation: $isEducation');
    debugPrint('isCourse: $isCourse');
    debugPrint('isCertificate: $isCertificate');
    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ✅ Title (skip for experience)
            if (!isExperience) ...[
              TextFormField(
                controller: cubit.titleController,
                decoration: const InputDecoration(labelText: 'Title'),
                validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 10),
            ],

            // ✅ Institution / Company
            TextFormField(
              controller: cubit.institutionController,
              decoration: InputDecoration(
                labelText: isExperience ? 'Company Name' : 'Institution Name',
              ),
              validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 10),

            // ✅ Dates
            if (isEducation || isExperience) ...[
              Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: cubit.startDateController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'Start Date'),
                      onTap: () => _pickDate(context, cubit.startDateController),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: TextFormField(
                      controller: cubit.endDateController,
                      readOnly: true,
                      decoration: const InputDecoration(labelText: 'End Date'),
                      onTap: () => _pickDate(context, cubit.endDateController),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 10),
            ] else ...[
              TextFormField(
                controller: cubit.startDateController,
                readOnly: true,
                decoration: InputDecoration(
                  labelText:
                  (isCourse || isCertificate) ? 'Date Issued' : 'Start Date',
                ),
                onTap: () => _pickDate(context, cubit.startDateController),
              ),
              const SizedBox(height: 10),
            ],

            // ✅ Job Info for experience
            if (isExperience) ...[
              DropdownButtonFormField<String>(
                value: cubit.selectedJobTitle,
                items: AppSharedData.jobTitle
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Job Title'),
                onChanged: (val) => cubit.setJobTitle(val!),
                validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 10),
              DropdownButtonFormField<String>(
                value: cubit.selectedJobType,
                items: AppSharedData.jobs
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Job Type'),
                onChanged: (val) => cubit.setJobType(val!),
                validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 10),
            ],

            // ✅ Description
            TextFormField(
              controller: cubit.descriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
              maxLines: 3,
              validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  void _pickDate(BuildContext context, TextEditingController controller) async {
    final picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1980),
      lastDate: DateTime(2100),
    );
    if (picked != null) {
      controller.text = picked.toIso8601String().split('T').first;
    }
  }
}
