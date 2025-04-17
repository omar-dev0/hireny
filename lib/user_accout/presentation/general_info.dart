import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/user_accout/presentation/widgets/side_bar.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import 'package:intl_phone_field/intl_phone_field.dart';
import '../../routes/page_route.dart';
import '../../utils/constants/app_assets.dart';
import '../../utils/constants/app_colors.dart';
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
    final cubit = context.read<UserCubit>();

    return Scaffold(
      backgroundColor: AppColors.white,
      drawer: SideBar(),
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
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              Center(
                child: Stack(
                  children: [
                    // image picker
                    BlocBuilder<UserCubit, UserStates>(
                      builder: (context, state) {
                        // Check for null before using cubit.selectedImage
                        if (cubit.selectedImage == null) {
                          return CircleAvatar(
                            radius: 70,
                            backgroundImage: AssetImage(AppAssets.profileImg),
                          );
                        }

                        return CircleAvatar(
                          radius: 70,
                          backgroundImage: FileImage(File(cubit.selectedImage!.path)),
                        );
                      },
                    ),

                    Positioned(
                      top: 100,
                      left: 90,
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
              SizedBox(height: 16),
              Form(
                key: cubit.formKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'First Name ',
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
                    ),
                    CustomTextField(
                      controller: cubit.firstNameController,
                      hint: "Enter your first name",
                      keyboardType: TextInputType.name,
                      onValidate:
                          (value) => cubit.validateText(value, "First name"),
                    ),
                    // last name
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Last Name ',
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
                    ),
                    CustomTextField(
                      controller: cubit.lastNameController,
                      hint: "Enter your last name",
                      keyboardType: TextInputType.name,
                      onValidate:
                          (value) => cubit.validateText(value, "Last name"),
                    ),
                    // date
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Birth of Date',
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
                    ),
                    // todo date checking
                    CustomTextField(
                      controller: cubit.birthDateController,
                      hint: "dd/mm/yyyy",
                      suffixWidget: Icon(Icons.calendar_month),
                      keyboardType: TextInputType.datetime,
                      onValidate: (value) => cubit.validateDate(value),
                    ),
                    SizedBox(height: 16),
                    Text(
                      "Email",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    CustomTextField(
                      controller: cubit.emailController,
                      hint: "Enter your email",
                      keyboardType: TextInputType.emailAddress,
                      onValidate: (value) => cubit.validateEmail(value),
                    ),
                    // phone
                    SizedBox(height: 16),
                    Text(
                      "Phone",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    IntlPhoneField(
                      initialCountryCode: 'EG',
                      cursorColor: AppColors.primary,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(16),
                          borderSide: const BorderSide(
                            color: AppColors.grey,
                            width: 1,
                          ),
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
                          borderSide: const BorderSide(
                            color: AppColors.primary,
                            width: 1,
                          ),
                        ),
                        errorBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(12),
                          borderSide: const BorderSide(
                            color: AppColors.red,
                            width: 1,
                          ),
                        ),
                        fillColor: Colors.white,
                        filled: true,
                      ),
                      onSaved: (phone) {
                        cubit.phoneNumber = phone?.completeNumber;
                        print(cubit.phoneNumber);
                      },

                      validator: (phone) {
                        print("VALIDATING: ${phone?.number}");
                        return cubit.validatePhoneNumber(phone?.number);
                      },
                    ),
                    // password
                    SizedBox(height: 16),
                    Text(
                      "Password",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                    CustomTextField(
                      controller: cubit.passwordController,
                      hint: "Enter your password",
                      isPassword: true,
                      maxLines: 1,
                      keyboardType: TextInputType.visiblePassword,
                      onValidate: (value) => cubit.validatePassword(value),
                    ),
                    SizedBox(height: 16),
                    RichText(
                      text: TextSpan(
                        children: [
                          TextSpan(
                            text: 'Gender ',
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
                    ),
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
            onChanged: (value) => cubit.updateGender(value),
          ),
        ),
        Expanded(
          child: RadioListTile<String>(
            title: const Text('Female'),
            value: 'Female',
            groupValue: cubit.selectedGender,
            activeColor: AppColors.primary,
            onChanged: (value) => cubit.updateGender(value),
          ),
        ),

      ],
    );    }),


                    SizedBox(height: 16,),
                    SizedBox(
                      width: double.infinity,
                      height: 50,
                      child: ElevatedButton(
                        onPressed: () {
                          if (cubit.formKey.currentState!.validate()) {
                            cubit.formKey.currentState!.save();
                            Navigator.pushNamed(context, PagesRoute.generalTechInfo);
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
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
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
}
