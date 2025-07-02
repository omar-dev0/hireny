import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lottie/lottie.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/widgets/custom_drop_down.dart';
import '../../../../utils/widgets/custom_text_field.dart';
import '../manager/service_org_cubit.dart';
import '../manager/service_org_states.dart';

class ServicePost extends StatelessWidget {
  const ServicePost({super.key});

  @override
  Widget build(BuildContext context) {
    final screen = MediaQuery.of(context).size;
    final theme = Theme.of(context);
    final spacing = screen.height * 0.02;

    return Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Text(
          "Post a service",
          style: Theme.of(context).textTheme.labelLarge?.copyWith(
              color: AppColors.white
          ),
        ),
        centerTitle: true,
        backgroundColor: AppColors.white,
      ),

      body: BlocBuilder<ServiceOrgCubit, ServiceOrgStates>(
        builder: (context, state) {
          final cubit = context.read<ServiceOrgCubit>();

          return Form(
            key: cubit.formKey,
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
                    controller: cubit.titleController,
                    hint: "Enter service title",
                    keyboardType: TextInputType.text,
                    onValidate:
                        (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: spacing),

                  CustomTextField(
                    label: "Currency",
                    controller: cubit.currencyController,
                    hint: "Enter currency",
                    keyboardType: TextInputType.text,
                    onValidate:
                        (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: spacing),

                  CustomTextField(
                    label: "Service Price",
                    controller: cubit.priceController,
                    hint: "Enter service price",
                    keyboardType: TextInputType.number,
                    onValidate:
                        (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: spacing),

                  CustomDropDown(
                    label: "Category",
                    selectItem: cubit.selectedCategory,
                    items: AppSharedData.categories,
                    onChanged: cubit.setCategory,
                  ),
                  SizedBox(height: spacing),

                  Row(
                    children: [
                      Expanded(
                        child: CustomDropDown(
                          label: "Country",
                          selectItem: cubit.selectedCountry,
                          items:
                              AppSharedData.countryCityData.keys
                                  .toList()
                                  .cast<String>(),
                          onChanged: cubit.setCountry,
                        ),
                      ),
                      SizedBox(width: screen.width * 0.04),
                      Expanded(
                        child: CustomDropDown(
                          label: "City",
                          selectItem: cubit.selectedCity,
                          items:
                              AppSharedData.countryCityData[cubit
                                  .selectedCountry] ??
                              [],
                          onChanged: cubit.setCity,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: spacing),

                  CustomTextField(
                    label: "Service Description",
                    controller: cubit.descriptionController,
                    hint: "Enter service description",
                    maxLines: 6,
                    keyboardType: TextInputType.multiline,
                    onValidate:
                        (val) => val == null || val.isEmpty ? 'Required' : null,
                  ),
                  SizedBox(height: spacing * 1.5),

                  Row(
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            cubit.submitForm(context);
                            Navigator.pop(context);
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primary,
                            padding: EdgeInsets.symmetric(
                              vertical: screen.height * 0.02,
                            ),
                          ),
                          child: Text(
                            "Post",
                            style: theme.textTheme.labelLarge?.copyWith(
                              color: Colors.white,
                            ),
                          ),
                        ),
                      ),
                      SizedBox(width: screen.width * 0.04),
                      Expanded(
                        child: OutlinedButton(
                          onPressed: () => Navigator.pop(context),
                          style: OutlinedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                              vertical: screen.height * 0.02,
                            ),
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
          );
        },
      ),
    );
  }
}
