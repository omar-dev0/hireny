import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/widgets/custom_drop_down.dart';
import '../../../../utils/widgets/custom_text_field.dart';

class ServicePost extends StatefulWidget {
  const ServicePost({super.key});

  @override
  State<ServicePost> createState() => _ServicePostState();
}

class _ServicePostState extends State<ServicePost> {
  final _formKey = GlobalKey<FormState>();
  final titleController = TextEditingController();
  final priceController = TextEditingController();
  final descriptionController = TextEditingController();

  String? selectedCountry;
  String? selectedCity;
  String? selectedCategory;

  final List<String> categories = [
    "Design",
    "Development",
    "Marketing",
    "Consulting",
    "Writing",
    "Other",
  ];

  @override
  void dispose() {
    titleController.dispose();
    priceController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate() &&
        selectedCountry != null &&
        selectedCity != null &&
        selectedCategory != null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Service posted successfully!')),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please complete all required fields')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final spacing = screen.height * 0.02;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: Icon(Icons.arrow_back,color: AppColors.primary,),
        backgroundColor: AppColors.white,
        automaticallyImplyLeading: false,
        surfaceTintColor: AppColors.white,
        title: Text(
          "Post a Service",
          style: theme.textTheme.titleLarge,
        ),
        centerTitle: true,
      ),

      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: EdgeInsets.all(screen.width * 0.04),
          child: Column(
            children: [
              Center(
                child: Lottie.asset(
                  'assets/animations/post.json',
                  width: screen.width * 0.6,
                  height: screen.height * 0.25,
                ),
              ),
              SizedBox(height: spacing),

              CustomTextField(
                label: "Service Title",
                controller: titleController,
                hint: "Enter service title",
                keyboardType: TextInputType.text,
                onValidate: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: spacing),

              CustomTextField(
                label: "Service Price",
                controller: priceController,
                hint: "Enter service price",
                keyboardType: TextInputType.number,
                onValidate: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: spacing),

              CustomDropDown(
                label: "Category",
                selectItem: selectedCategory,
                items: categories,
                onChanged: (val) => setState(() => selectedCategory = val),
              ),
              SizedBox(height: spacing),

              Row(
                children: [
                  Expanded(
                    child: CustomDropDown(
                      label: "Country",
                      selectItem: selectedCountry,
                      items: AppSharedData.countryCityData.keys.toList().cast<String>(),
                      onChanged: (val) => setState(() {
                        selectedCountry = val;
                        selectedCity = null;
                      }),
                    ),
                  ),
                  SizedBox(width: screen.width * 0.04),
                  Expanded(
                    child: CustomDropDown(
                      label: "City",
                      selectItem: selectedCity,
                      items: AppSharedData.countryCityData[selectedCountry] ?? [],
                      onChanged: (val) => setState(() => selectedCity = val),
                    ),
                  ),
                ],
              ),
              SizedBox(height: spacing),

              CustomTextField(
                label: "Service Description",
                controller: descriptionController,
                hint: "Enter service description",
                maxLines: 6,
                keyboardType: TextInputType.multiline,
                onValidate: (val) => val == null || val.isEmpty ? 'Required' : null,
              ),
              SizedBox(height: spacing * 1.5),

              Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: _submitForm,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        padding: EdgeInsets.symmetric(vertical: screen.height * 0.02),
                      ),
                      child: Text(
                        "Post",
                        style: theme.textTheme.labelLarge?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  SizedBox(width: screen.width * 0.04),
                  Expanded(
                    child: OutlinedButton(
                      onPressed: () => Navigator.pop(context),
                      style: OutlinedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: screen.height * 0.02),

                      ),
                      child: Text(
                        "Cancel",
                        style: theme.textTheme.labelLarge,
                      ),
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
