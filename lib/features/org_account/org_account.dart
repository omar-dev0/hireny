import 'dart:io';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/core/widgets/sideBar.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import '../../routes/page_route.dart';
import '../../utils/constants/app_colors.dart';
import '../../utils/data_shared/app_shared_data.dart';
import '../../utils/widgets/custom_drop_down.dart';
import '../../utils/widgets/custom_text_field.dart';
import '../auth/view/profile/cubit/user_cubit.dart';
import '../auth/view/profile/cubit/user_states.dart';
import '../auth/view/profile/widgets/image_picker.dart';

class OrgAccount extends StatefulWidget {
  const OrgAccount({super.key});

  @override
  State<OrgAccount> createState() => _OrgAccountState();
}

class _OrgAccountState extends State<OrgAccount> {
  late final UserCubit cubit;

  @override
  void initState() {
    super.initState();
    cubit = context.read<UserCubit>();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "Organization Profile",
      drawer: SideBarScreen(currentRoute: PagesRoute.orgAccount),
      body: Form(
        key: cubit.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const SizedBox(height: 16),
              /// Avatar
              FadeInDown(
                duration: const Duration(milliseconds: 400),
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    BlocBuilder<UserCubit, UserStates>(
                      builder: (context, state) {
                        final selected = cubit.selectedImage;
                        final validFile =
                            selected != null && File(selected.path).existsSync();

                        return AnimatedSwitcher(
                          duration: const Duration(milliseconds: 400),
                          child: validFile
                              ? CircleAvatar(
                            key: const ValueKey('picked_avatar'),
                            radius: 50,
                            backgroundImage: FileImage(File(selected.path)),
                          )
                              : const CircleAvatar(
                            key: ValueKey('default_avatar'),
                            radius: 50,
                            child: Icon(Icons.person, size: 50),
                          ),
                        );
                      },
                    ),
                    Positioned(
                      bottom: -5,
                      right: -5,
                      child: GestureDetector(
                        onTap: () {
                          showModalBottomSheet(
                            context: context,
                            backgroundColor: Colors.transparent,
                            isScrollControlled: true,
                            builder: (context) => BlocProvider.value(
                              value: cubit,
                              child: const ImagePickerBottomSheet(),
                            ),
                          );
                        },
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color: Theme.of(context).primaryColor,
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(Icons.edit, size: 20, color: Colors.white),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              /// Fields
              CustomTextField(
                label: "Name",
                controller: cubit.nameController,
                hint: "Enter your name",
                prefixIcon: const Icon(Icons.person_outline),
                keyboardType: TextInputType.name,
                onValidate: (val) => cubit.validateText(val, "Name"),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "CEO",
                controller: cubit.ceoController,
                hint: "Enter CEO's name",
                prefixIcon: const Icon(Icons.person_outline),
                keyboardType: TextInputType.name,
                onValidate: (val) => cubit.validateText(val, "CEO"),
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Email",
                controller: cubit.emailController,
                hint: "Enter your email",
                prefixIcon:
                Icon(Icons.email_outlined, color: AppColors.grey.withAlpha(120)),
                keyboardType: TextInputType.emailAddress,
                onValidate: cubit.validateEmail,
                enabled: cubit.updated,
              ),
              const SizedBox(height: 16),
              CustomTextField(
                label: "Phone Number",
                controller: cubit.phoneController,
                hint: "+20XXXXXXXXX",
                prefixIcon:
                Icon(Icons.phone_outlined, color: AppColors.grey.withAlpha(120)),
                keyboardType: TextInputType.phone,
                onValidate: cubit.validatePhoneNumber,
              ),
              const SizedBox(height: 16),

              /// Birth Date
              GestureDetector(
                onTap: () async {
                  final pickedDate = await showDatePicker(
                    context: context,
                    initialDate: DateTime.now(),
                    firstDate: DateTime(1900),
                    lastDate: DateTime(2100),
                  );
                  if (pickedDate != null) {
                    setState(() {
                      cubit.birthDateController.text =
                      "${pickedDate.year}-${pickedDate.month.toString().padLeft(2, '0')}-${pickedDate.day.toString().padLeft(2, '0')}";
                    });
                  }
                },
                child: AbsorbPointer(
                  child: CustomTextField(
                    label: "Birth Date",
                    controller: cubit.birthDateController,
                    hint: "yyyy/mm/dd",
                    prefixIcon: const Icon(Icons.calendar_today_outlined),
                    // onValidate: cubit.,
                  ),
                ),
              ),
              const SizedBox(height: 16),

              /// Country & City
              Row(
                children: [
                  Expanded(
                    child: CustomDropDown(
                      label: "Country",
                      selectItem: cubit.country,
                      items: AppSharedData.countryCityData.keys.toList(),
                      onChanged: (val) {
                        setState(() {
                          cubit.country = val;
                          cubit.city = null;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDropDown(
                      label: "City",
                      selectItem: cubit.city,
                      items: AppSharedData.countryCityData[cubit.country] ?? [],
                      onChanged: (val) {
                        setState(() {
                          cubit.city = val;
                        });
                      },
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 16),

              /// Industry & Org Size
              Row(
                children: [
                  Expanded(
                    child: CustomDropDown(
                      label: "Industry",
                      items: AppSharedData.industries,
                      selectItem: cubit.industry,
                      onChanged: (value) {
                        setState(() {
                          cubit.setIndustry(value!);
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: CustomDropDown(
                      label: "Organization Size",
                      items: AppSharedData.organizationSizes,
                      selectItem: cubit.orgSize,
                      onChanged: (value) {
                        setState(() {
                          cubit.setOrgSize(value!);
                        });
                      },
                    ),
                  ),
                ],
              ),

              /// Brief & Description Section
              const SizedBox(height: 16),
              CustomTextField(
                label: "Brief",
                controller: cubit.briefController,
                prefixIcon: Icon(Icons.short_text, color: AppColors.grey.withAlpha(120)),
                keyboardType: TextInputType.text,
                maxLines: 7,
                minLines: 3,
              ),

              const SizedBox(height: 24),

              /// Social Links Section
              _buildSocialLinksSection(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSocialLinksSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              "Social Links",
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                fontWeight: FontWeight.w500,
              ),
            ),
            TextButton.icon(
              onPressed: () {
                setState(() {
                  cubit.addFieldPair();
                });
              },
              icon: Icon(
                Icons.add_circle_outline,
                color: Theme.of(context).primaryColor,
              ),
              label: Text(
                "Add Link",
                style: TextStyle(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ),
          ],
        ),
        ...List.generate(
          cubit.fieldPairs.length,
              (index) => Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomDropDown(
                      label: "Link Type",
                      items: cubit.linkTypes,
                      selectItem: cubit.fieldPairs[index]['type'],
                      onChanged: (val) {
                        setState(() {
                          cubit.fieldPairs[index]['type'] = val;
                        });
                      },
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 3,
                    child: CustomTextField(
                      controller: cubit.fieldPairs[index]['value'],
                      label: "URL",
                      hint: "https://example.com",
                      keyboardType: TextInputType.url,
                      onValidate: (val) => cubit.validateLink(val),
                    ),
                  ),
                ],
              ),
              if (cubit.linksLen > 1)
                Align(
                  alignment: Alignment.centerRight,
                  child: IconButton(
                    icon: const Icon(Icons.delete_outline, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        cubit.removeFieldPair(index);
                      });
                    },
                  ),
                ),
              const SizedBox(height: 12),
            ],
          ),
        ),
      ],
    );
  }
}
