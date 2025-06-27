import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';

class FormAddInfo extends StatelessWidget {
  const FormAddInfo({super.key});

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<TechnicalInfoCubit>();

    return Form(
      key: cubit.formKey,
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            // Title / Degree / Job Title
            TextFormField(
              controller: cubit.titleController,
              decoration: const InputDecoration(labelText: 'Title'),
              validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 10),

            // Institution / Company
            TextFormField(
              controller: cubit.institutionController,
              decoration: InputDecoration(
                labelText: cubit.isExperience ? 'Company Name' : 'Institution Name',
              ),
              validator: (value) =>
              (value == null || value.trim().isEmpty) ? 'Required' : null,
            ),
            const SizedBox(height: 10),

            // Start and End Date fields
            if (cubit.isEducation || cubit.isExperience) ...[
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
                  labelText: (cubit.isCourse || cubit.isCertificate)
                      ? 'Date Issued'
                      : 'Start Date',
                ),
                onTap: () => _pickDate(context, cubit.startDateController),
              ),
              const SizedBox(height: 10),
            ],

            // Dropdowns for Experience
            if (cubit.isExperience) ...[
              DropdownButtonFormField<String>(
                value: cubit.selectedJobTitle,
                items: cubit.jobTitles
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
                items: cubit.jobTypes
                    .map((e) => DropdownMenuItem(value: e, child: Text(e)))
                    .toList(),
                decoration: const InputDecoration(labelText: 'Job Type'),
                onChanged: (val) => cubit.setJobType(val!),
                validator: (value) =>
                (value == null || value.trim().isEmpty) ? 'Required' : null,
              ),
              const SizedBox(height: 10),
            ],

            // Description
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
