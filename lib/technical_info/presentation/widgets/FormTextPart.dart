import 'package:flutter/material.dart';
import 'package:hireny/technical_info/presentation/widgets/popUpTextField.dart';


class FormTextPart extends StatelessWidget {
  final TextEditingController nameController;
  final TextEditingController emailController;
  final TextEditingController startingYear;
  final TextEditingController endingYear;

  FormTextPart({
    super.key,
    required this.nameController,
    required this.emailController,
    required this.startingYear,
    required this.endingYear,
    required this.formKey,
  });

  final GlobalKey<FormState> formKey; // this can be moved to the parent if needed

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 10.0),
        child: Column(
          children: [
            Text('Enter Your Info', style: Theme.of(context).textTheme.titleLarge),
            const SizedBox(height: 20),
            Popuptextfield(
              controller: nameController,
              title: "Job Name",
              validator: (value) => value == null || value.isEmpty ? 'Enter job name' : null,
            ),
            const SizedBox(height: 20),
            Popuptextfield(
              controller: emailController,
              title: "Company Name",
              validator: (value) => value == null || value.isEmpty ? 'Enter company name' : null,
            ),
            const SizedBox(height: 20),
            Row(
              children: [
                Flexible(
                  child: Popuptextfield(
                    controller: startingYear,
                    title: 'Starting Year',
                    validator: (value) => value == null || value.isEmpty ? 'Enter start year' : null,
                  ),
                ),
                const SizedBox(width: 15),
                Flexible(
                  child: Popuptextfield(
                    controller: endingYear,
                    title: 'End At',
                    validator: (value) => value == null || value.isEmpty ? 'Enter end year' : null,
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
