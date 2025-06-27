import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpTextField.dart';


class FormTextPart extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController startingYear;
  final TextEditingController endingYear;
  final TextEditingController descriptionController; // NEW
  final GlobalKey<FormState> formKey;

  const FormTextPart({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.startingYear,
    required this.endingYear,
    required this.descriptionController, // NEW
    required this.formKey,
  });

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          TextFormField(
            controller: nameController,
            decoration: const InputDecoration(labelText: 'Title'),
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: emailController,
            decoration: const InputDecoration(labelText: 'Company Name'),
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: startingYear,
            readOnly: true,
            decoration: const InputDecoration(labelText: 'Start Date'),
            onTap: () => _pickDate(context, startingYear),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: endingYear,
            readOnly: true,
            decoration: const InputDecoration(labelText: 'End Date'),
            onTap: () => _pickDate(context, endingYear),
          ),
          const SizedBox(height: 10),
          TextFormField(
            controller: descriptionController,
            decoration: const InputDecoration(labelText: 'Description'),
            maxLines: 3,
            validator: (val) => val == null || val.isEmpty ? 'Required' : null,
          ),
        ],
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
