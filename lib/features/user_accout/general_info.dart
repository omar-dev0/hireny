import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/user_accout/widgets/side_bar.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';

import '../../../../routes/page_route.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/constants/app_colors.dart';
import 'cubit/user_cubit.dart';
import 'cubit/user_states.dart';

class GeneralInfo extends StatefulWidget {
  const GeneralInfo({super.key});

  @override
  State<GeneralInfo> createState() => _GeneralInfoState();
}

class _GeneralInfoState extends State<GeneralInfo>
    with TickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeIn));

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  bottomSheet(UserCubit cubit) {
    return Container(
      width: double.infinity,
      height: 200,
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Text(
            "Choose profile photo",
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              InkWell(
                onTap: cubit.onPickImage,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.photo_library, size: 50),
                    Text("Gallery", style: TextStyle(fontSize: 24)),
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();

    return BlocConsumer<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is InitialState) {
          print("hello world");
        }
      },
      builder: (context, state) {
        return Scaffold(
          backgroundColor: AppColors.white,
          drawer: SideBar(index: 0),
          appBar: AppBar(
            title: const Text(
              'Personal Info',
              style: TextStyle(color: Colors.black),
            ),
            centerTitle: true,
            backgroundColor: Colors.white,
            iconTheme: const IconThemeData(color: AppColors.primary),
          ),
          body: SingleChildScrollView(
            child: FadeTransition(
              opacity: _fadeAnimation,
              child: SlideTransition(
                position: _slideAnimation,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      Center(
                        child: Stack(
                          children: [
                            BlocBuilder<UserCubit, UserStates>(
                              builder: (context, state) {
                                return AnimatedSwitcher(
                                  duration: Duration(milliseconds: 400),
                                  child:
                                      cubit.selectedImage == null
                                          ? CircleAvatar(
                                            key: ValueKey('default_avatar'),
                                            radius: 60,
                                            backgroundImage: AssetImage(
                                              AppAssets.profileImg,
                                            ),
                                          )
                                          : CircleAvatar(
                                            key: ValueKey('picked_avatar'),
                                            radius: 70,
                                            backgroundImage: FileImage(
                                              File(cubit.selectedImage!.path),
                                            ),
                                          ),
                                );
                              },
                            ),
                            Positioned(
                              top: 80,
                              left: 70,
                              child: InkWell(
                                onTap: () {
                                  showModalBottomSheet(
                                    context: context,
                                    builder: (context) => bottomSheet(cubit),
                                  );
                                },
                                child: Icon(
                                  Icons.photo_camera,
                                  size: 40,
                                  color: AppColors.primary,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 16),
                      Form(
                        key: cubit.formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            buildLabel('First Name'),
                            CustomTextField(
                              controller: cubit.firstNameController,
                              hint: "Enter your first name",
                              keyboardType: TextInputType.name,
                              onValidate:
                                  (value) =>
                                      cubit.validateText(value, "First name"),
                            ),
                            const SizedBox(height: 16),
                            buildLabel('Last Name'),
                            CustomTextField(
                              controller: cubit.lastNameController,
                              hint: "Enter your last name",
                              keyboardType: TextInputType.name,
                              onValidate:
                                  (value) =>
                                      cubit.validateText(value, "Last name"),
                            ),
                            const SizedBox(height: 16),
                            buildLabel('Birth of Date'),
                            CustomTextField(
                              controller: cubit.birthDateController,
                              hint: "dd/mm/yyyy",
                              suffixWidget: Icon(Icons.calendar_month),
                              keyboardType: TextInputType.datetime,
                              onValidate: (value) => cubit.validateDate(value),
                            ),
                            const SizedBox(height: 16),
                            buildPlainLabel('Email'),
                            CustomTextField(
                              controller: cubit.emailController,
                              hint: "Enter your email",
                              keyboardType: TextInputType.emailAddress,
                              onValidate: (value) => cubit.validateEmail(value),
                            ),
                            const SizedBox(height: 16),
                            buildPlainLabel('Phone'),
                            IntlPhoneField(
                              initialCountryCode: 'EG',
                              cursorColor: AppColors.primary,
                              keyboardType: TextInputType.phone,
                              decoration: buildInputDecoration(),
                              onSaved:
                                  (phone) =>
                                      cubit.phoneNumber = phone?.completeNumber,
                              validator:
                                  (phone) =>
                                      cubit.validatePhoneNumber(phone?.number),
                            ),
                            const SizedBox(height: 16),
                            buildLabel('Gender'),
                            BlocBuilder<UserCubit, UserStates>(
                              builder: (context, state) {
                                return Row(
                                  children: [
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text('Male'),
                                        value: 'Male',
                                        groupValue: cubit.selectedGender,
                                        activeColor: AppColors.primary,
                                        onChanged:
                                            (value) =>
                                                cubit.updateGender(value),
                                      ),
                                    ),
                                    Expanded(
                                      child: RadioListTile<String>(
                                        title: const Text('Female'),
                                        value: 'Female',
                                        groupValue: cubit.selectedGender,
                                        activeColor: AppColors.primary,
                                        onChanged:
                                            (value) =>
                                                cubit.updateGender(value),
                                      ),
                                    ),
                                  ],
                                );
                              },
                            ),
                            const SizedBox(height: 16),
                            Row(
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
                                      backgroundColor: AppColors.primary,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                      ),
                                    ),
                                    child: const Text(
                                      "Next",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Colors.white,
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(width: 16),
                                Expanded(
                                  child: ElevatedButton(
                                    onPressed: () {},
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.white,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(12),
                                        side: BorderSide(
                                          color: AppColors.primary,
                                        ),
                                      ),
                                    ),
                                    child: Text(
                                      "ChangePassword",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: AppColors.primary,
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  Widget buildLabel(String text) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            text: '$text ',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.black,
            ),
          ),
          TextSpan(
            text: '*',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: Colors.red,
            ),
          ),
        ],
      ),
    );
  }

  Widget buildPlainLabel(String text) {
    return Text(
      text,
      style: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.black,
      ),
    );
  }

  InputDecoration buildInputDecoration() {
    return InputDecoration(
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.grey, width: 1),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(
          color: AppColors.grey.withOpacity(0.5),
          width: 1,
        ),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: const BorderSide(color: AppColors.primary, width: 1),
      ),
      errorBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: const BorderSide(color: AppColors.red, width: 1),
      ),
      fillColor: Colors.white,
      filled: true,
    );
  }
}
