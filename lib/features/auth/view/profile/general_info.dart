import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/view/profile/widgets/image_picker.dart';
import 'package:hireny/features/auth/view/profile/widgets/image_picker.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../../../core/widgets/sideBar.dart';
import '../../../../routes/page_route.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import '../../../../utils/constants/dialogs/loading_dialog.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/widgets/custom_drop_down.dart';
import 'cubit/user_cubit.dart';
import 'cubit/user_states.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({super.key});

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo> {
  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is LoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => const LoadingDialog(),
          );
        } else if (state is SuccessUpdatedState || state is ErrorUpdatedState) {
          Navigator.of(context, rootNavigator: true).pop();
        }

        if (state is ErrorUpdatedState) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(state.message ?? "An error occurred"),
              behavior: SnackBarBehavior.floating,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              backgroundColor: AppColors.red,
            ),
          );
        }
      },
      builder: (context, state) {
        final cubit = context.read<UserCubit>();
        return CustomScreen(
          title: "General Info",
          drawer: SideBarScreen(currentRoute: PagesRoute.generalInfo),
          body: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
            child: Column(
              children: [
                // Profile Picture Section
            FadeInDown(
            duration: const Duration(milliseconds: 400),
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                BlocBuilder<UserCubit, UserStates>(
                  builder: (context, state) {
                    final selected = cubit.selectedImage;
                    final validFile = selected != null && File(selected.path).existsSync();

                    return AnimatedSwitcher(
                      duration: const Duration(milliseconds: 400),
                      child: validFile
                          ? CircleAvatar(
                        key: const ValueKey('picked_avatar'),
                        radius: 60,
                        backgroundImage: FileImage(File(selected.path)),
                      )
                          : CircleAvatar(
                        key: const ValueKey('default_avatar'),
                        radius: 60,
                        child: Icon(Icons.person, size: 50),
                      ),
                    );
                  },
                ),   Positioned(
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

                // Form Section
                FadeInUp(
                  duration: const Duration(milliseconds: 600),
                  child: BlocBuilder<UserCubit, UserStates>(
                    builder: (context, state) {
                      final cubit = context.read<UserCubit>();
                      return Form(
                        key: cubit.formKey,
                        child: Column(
                          children: [
                            // Name Section
                            Row(
                              children: [
                                Expanded(
                                  child: FadeInRight(
                                    delay: const Duration(milliseconds: 100),
                                    child: CustomTextField(
                                      label: "First Name",
                                      controller: cubit.firstNameController,
                                      hint: "Enter your first name",
                                      prefixIcon: Icon(Icons.person_outline),
                                      keyboardType: TextInputType.name,
                                      onValidate: (value) =>
                                          cubit.validateText(value, "First name"),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: FadeInLeft(
                                    delay: const Duration(milliseconds: 200),
                                    child: CustomTextField(
                                      label: "Last Name",
                                      controller: cubit.lastNameController,
                                      hint: "Enter your last name",
                                      keyboardType: TextInputType.name,
                                      onValidate: (value) =>
                                          cubit.validateText(value, "Last name"),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            const SizedBox(height: 16),

                            // Birth Date
                            // todo try to sp
                            FadeInRight(
                              delay: const Duration(milliseconds: 300),
                              child: GestureDetector(
                                onTap: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime(1900),
                                    lastDate: DateTime(2100),
                                    builder: (context, child) {
                                      return Theme(
                                        data: Theme.of(context).copyWith(
                                          colorScheme: ColorScheme.light(
                                            primary: Theme.of(context).primaryColor,
                                            onPrimary: Colors.white,
                                            onSurface: Colors.black,
                                          ),
                                          textButtonTheme: TextButtonThemeData(
                                            style: TextButton.styleFrom(
                                              foregroundColor:
                                              Theme.of(context).primaryColor,
                                            ),
                                          ),
                                        ),
                                        child: child!,
                                      );
                                    },
                                  );
                                  if (pickedDate != null) {
                                    cubit.birthDateController.text =
                                    "${pickedDate.day.toString().padLeft(2, '0')}/${pickedDate.month.toString().padLeft(2, '0')}/${pickedDate.year}";
                                  }
                                },
                                child: AbsorbPointer(
                                  child: CustomTextField(
                                    label: "Birth Date",
                                    controller: cubit.birthDateController,
                                    hint: "yyyy/mm/dd",
                                    prefixIcon: Icon(Icons.calendar_today_outlined),
                                    onValidate: (value) =>
                                        cubit.validateDate(value),
                                  ),
                                ),
                              ),
                            ),

                            const SizedBox(height: 16),

                            // Email
                            FadeInLeft(
                              delay: const Duration(milliseconds: 400),
                              child: CustomTextField(
                                label: "Email",
                                controller: cubit.emailController,
                                hint: "Enter your email",
                                prefixIcon: Icon(Icons.email_outlined,color:AppColors.grey.withValues(alpha: 0.5)),
                                keyboardType: TextInputType.emailAddress,
                                onValidate: (value) => cubit.validateEmail(value),
                                enabled: false,
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Phone Field
                            FadeInRight(
                              delay: const Duration(milliseconds: 500),
                              child: CustomTextField(
                                label: "Phone Number",
                                controller: cubit.phoneController,
                                hint: "+20XXXXXXXXX",
                                prefixIcon: Icon(Icons.phone_outlined, color: AppColors.grey.withAlpha(120)),
                                keyboardType: TextInputType.phone,
                                onValidate: (value) => cubit.validatePhoneNumber(value),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Location Section
                            FadeInUp(
                              delay: const Duration(milliseconds: 600),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: CustomDropDown(
                                      label: "Country",
                                      selectItem: cubit.country,
                                      items: AppSharedData.countryCityData.keys
                                          .toList()
                                          .cast<String>(),
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
                                      items: AppSharedData.countryCityData[
                                      cubit.country] ??
                                          [],
                                      onChanged: (val) {
                                        cubit.city = val;
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Gender
                            FadeInDown(
                              delay: const Duration(milliseconds: 700),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    "Gender",
                                    style: theme.textTheme.bodyLarge?.copyWith(
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  const SizedBox(height: 8),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                        color: Colors.grey.shade300,
                                      ),
                                    ),
                                    child: BlocBuilder<UserCubit, UserStates>(
                                      builder: (context, state) {
                                        return Row(
                                          children: [
                                            Expanded(
                                              child: RadioListTile<String>(
                                                title: const Text('Male'),
                                                value: 'male',
                                                groupValue: cubit.selectedGender,
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                activeColor:
                                                Theme.of(context).primaryColor,
                                                onChanged: (value) =>
                                                    cubit.updateGender(value),
                                              ),
                                            ),
                                            Expanded(
                                              child: RadioListTile<String>(
                                                title: const Text('Female'),
                                                value: 'female',
                                                groupValue: cubit.selectedGender,
                                                contentPadding: EdgeInsets.zero,
                                                dense: true,
                                                activeColor:
                                                Theme.of(context).primaryColor,
                                                onChanged: (value) =>
                                                    cubit.updateGender(value),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Professional Info
                            FadeInLeft(
                              delay: const Duration(milliseconds: 800),
                              child: Column(
                                children: [
                                  CustomTextField(
                                    label: "Professional Title",
                                    controller: cubit.titleController,
                                    hint: "E.g. Senior Flutter Developer",
                                    prefixIcon: Icon(Icons.work_outline),
                                    keyboardType: TextInputType.name,
                                    onValidate: (value) =>
                                        cubit.validateText(value, "title"),
                                  ),
                                  const SizedBox(height: 16),
                                  Row(
                                    children: [
                                      Expanded(
                                        child: CustomDropDown(
                                          label: "Career Level",
                                          items: cubit.careerLevels,
                                          selectItem: cubit.selectedCareerLevel,
                                          onChanged: cubit.setCareerLevel,
                                        ),
                                      ),
                                      const SizedBox(width: 16),
                                      Expanded(
                                        child: CustomDropDown(
                                          label: "Employment Status",
                                          items: cubit.employmentStatusList,
                                          selectItem:
                                          cubit.selectedEmploymentStatus,
                                          onChanged: cubit.setEmploymentStatus,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),

                            // About/Brief
                            FadeInRight(
                              delay: const Duration(milliseconds: 900),
                              child: CustomTextField(
                                label: "About You",
                                controller: cubit.briefController,
                                hint:
                                "Write a brief summary about your professional background...",
                                keyboardType: TextInputType.multiline,
                                maxLines: 4,
                                onValidate: (value) =>
                                    cubit.validateText(value, "brief"),
                              ),
                            ),
                            const SizedBox(height: 16),

                            // Links Section
                            FadeInUp(
                              delay: const Duration(milliseconds: 1000),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        "Social Links",
                                        style: theme.textTheme.bodyLarge?.copyWith(
                                          fontWeight: FontWeight.w500,
                                        ),
                                      ),
                                      TextButton.icon(
                                        onPressed:(){},
                                        icon: Icon(
                                          Icons.add_circle_outline,
                                          color: Theme.of(context).primaryColor,
                                        ),
                                        label: Text(
                                          "Add Link",
                                          style: TextStyle(
                                              color:
                                              Theme.of(context).primaryColor),
                                        ),
                                      ),
                                    ],
                                  ),
                                  ...List.generate(
                                    cubit.getLen(),
                                        (index) => Column(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            // Dropdown for Link Type
                                            Expanded(
                                              flex: 2,
                                              child: CustomDropDown(
                                                label: "Link Type",
                                                items: cubit.linkTypes,
                                                selectItem: cubit.fieldPairs[index]['type'],
                                                onChanged: (val) {
                                                  cubit.fieldPairs[index]['type'] = val;
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
                                        if (cubit.getLen() > 1)
                                          Align(
                                            alignment: Alignment.centerRight,
                                            child: IconButton(
                                              icon: const Icon(Icons.delete_outline, color: Colors.red),
                                              onPressed: () => cubit.removeFieldPair(index),
                                            ),
                                          ),
                                        const SizedBox(height: 12),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 32),

                            // Action Buttons
                            FadeInUp(
                              delay: const Duration(milliseconds: 1100),
                              child: Row(
                                children: [
                                  Expanded(
                                    child: ElevatedButton(
                                      onPressed: () {
                                        if (cubit.formKey.currentState!
                                            .validate()) {
                                          cubit.formKey.currentState!.save();
                                          Navigator.pushNamed(
                                            context,
                                            PagesRoute.generalTechInfo,
                                          );
                                        }
                                      },
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor:
                                        Theme.of(context).primaryColor,
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        elevation: 2,
                                      ),
                                      child: Text(
                                        "Save changes",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 16),
                                  Expanded(
                                    child: OutlinedButton(
                                      onPressed: () {
                                        Navigator.pushNamed(
                                          context,
                                          PagesRoute.changePassword,
                                        );
                                      },
                                      style: OutlinedButton.styleFrom(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 16),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                          BorderRadius.circular(12),
                                        ),
                                        side: BorderSide(
                                          color: Theme.of(context).primaryColor,
                                        ),
                                      ),
                                      child: Text(
                                        "Change Password",
                                        style: theme.textTheme.labelLarge
                                            ?.copyWith(
                                          color: Theme.of(context).primaryColor,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
  Widget _buildImagePickerOption({
    required IconData icon,
    required String label,
    required VoidCallback onTap,
  }) {
    return FadeInUp(
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 120,
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(0.1),
            borderRadius: BorderRadius.circular(16),
            border: Border.all(
              color: Theme.of(context).primaryColor.withOpacity(0.2),
            ),
          ),
          child: Column(
            children: [
              Icon(icon, size: 36, color: Theme.of(context).primaryColor),
              const SizedBox(height: 8),
              Text(
                label,
                style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).primaryColor,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
  Widget _buildImagePickerBottomSheet(UserCubit cubit) {
    return Container(
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2),
            blurRadius: 20,
            offset: const Offset(0, -5),
          ),
        ],
      ),
      padding: const EdgeInsets.all(24),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 5,
            margin: const EdgeInsets.only(bottom: 16),
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              borderRadius: BorderRadius.circular(10),
            ),
          ),
          Text(
            "Choose Profile Photo",
            style: Theme.of(context).textTheme.titleLarge?.copyWith(
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 24),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildImagePickerOption(
                icon: Icons.photo_library_rounded,
                label: "Gallery",
                onTap: () => cubit.onPickImage(ImageSource.gallery),
              ),
              _buildImagePickerOption(
                icon: Icons.camera_alt_rounded,
                label: "Camera",
                onTap: () => cubit.onPickImage(ImageSource.camera),
              ),
            ],
          ),
          const SizedBox(height: 16),
        ],
      ),
    );
  }

}