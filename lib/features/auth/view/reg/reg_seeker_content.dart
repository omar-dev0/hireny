import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/auth/view/widgets/gender_widget.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import '../../../../utils/app_assets.dart';
import '../../../../utils/lang/lang.dart';
import '../../../../utils/validation/inputs_validator.dart';
import '../../../../utils/widgets/custom_drop_down.dart';
import '../../../../utils/widgets/custom_text_field.dart';
import '../widgets/date_widget.dart';
import 'cubit/reg_vm.dart';

class RegSeekerContent extends StatefulWidget {
  const RegSeekerContent({super.key});

  @override
  State<RegSeekerContent> createState() => _RegSeekerContentState();
}

class _RegSeekerContentState extends State<RegSeekerContent> {
  Widget animatedGroup(Widget child, int index) {
    return FadeInUp(
      duration: const Duration(milliseconds: 500),
      delay: Duration(milliseconds: 150 * index),
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    RegSeekerVm regVm = BlocProvider.of<RegSeekerVm>(context);
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Form(
            key: regVm.formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(Lang.regeForm, style: AppFonts.mainText),
                        SizedBox(height: 5.h),
                        Text(
                          Lang.regTitle,
                          style: AppFonts.hintStyle.copyWith(fontSize: 13.cSp),
                        ),
                      ],
                    ),
                    0,
                  ),
                  SizedBox(height: 30.h),

                  // Name Section
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.firstName,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.firstName,
                          hint: Lang.firstNameHint,
                          onValidate: emptyFieldValidator,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.lastName,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.lastName,
                          hint: Lang.lastNameHint,
                          onValidate: emptyFieldValidator,
                        ),
                      ],
                    ),
                    1,
                  ),
                  SizedBox(height: 20.h),

                  // Email Section
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.email,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.email,
                          keyboardType: TextInputType.emailAddress,
                          hint: Lang.emailHint,
                          onValidate: emailValidation,
                        ),
                      ],
                    ),
                    2,
                  ),
                  SizedBox(height: 20.h),

                  // Passwords
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.password,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          isPassword: true,
                          controller: regVm.password,
                          hint: Lang.passwordHint,
                          onValidate: passwordValidator,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.confirmPassword,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          isPassword: true,
                          controller: regVm.confirmPassword,
                          hint: Lang.confirmPassword,
                          onValidate: regVm.checkValidConfirmPassword,
                        ),
                      ],
                    ),
                    3,
                  ),
                  SizedBox(height: 20.h),

                  // Phone and DOB
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.phone,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.phone,
                          keyboardType: TextInputType.phone,
                          hint: Lang.phoneHint,
                          onValidate: emptyFieldValidator,
                        ),
                        SizedBox(height: 6.h),
                        Text(
                          Lang.phoneNote,
                          style: AppFonts.hintStyle.copyWith(fontSize: 13.cSp),
                        ),
                        SizedBox(height: 20.h),
                        Row(
                          children: [
                            Expanded(
                              child: InkWell(
                                onTap: () async {
                                  regVm.date = await showDatePicker(
                                    context: context,
                                    firstDate: DateTime(1900),
                                    initialDate: DateTime.now(),
                                    lastDate: DateTime(2100),
                                  );
                                  if (regVm.date != null) {
                                    regVm.dob =
                                        "${regVm.date!.year}-${regVm.date!.month}-${regVm.date!.day}";
                                  }
                                  setState(() {});
                                },
                                child: DateWidget(
                                  content: regVm.dob,
                                  label: Lang.dob,
                                ),
                              ),
                            ),
                            Expanded(
                              child: GenderSelector(
                                onGenderSelected: (String? value) {
                                  regVm.gender = value;
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    4,
                  ),
                  SizedBox(height: 20.h),

                  // Title and Nationality
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.title,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.titleController,
                          hint: Lang.jobTitleHint,
                          onValidate: emptyFieldValidator,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.nationality,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomDropDown(
                          selectItem: regVm.nationality,
                          label: Lang.nationalityHint,
                          items: AppSharedData.nationalities,
                          onChanged: (val) {
                            regVm.nationality = val;
                          },
                        ),
                      ],
                    ),
                    5,
                  ),
                  SizedBox(height: 20.h),

                  // Country and City
                  animatedGroup(
                    Row(
                      children: [
                        Expanded(
                          child: CustomDropDown(
                            selectItem: regVm.country,
                            label: Lang.countryHint,
                            items:
                                AppSharedData.countryCityData.keys
                                    .toList()
                                    .cast<String>(),
                            onChanged: (val) {
                              setState(() {
                                regVm.country = val;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: CustomDropDown(
                            selectItem: regVm.city,
                            label: Lang.cityHint,
                            items:
                                AppSharedData.countryCityData[regVm.country] ??
                                [],
                            onChanged: (val) {
                              regVm.city = val;
                            },
                          ),
                        ),
                      ],
                    ),
                    6,
                  ),
                  SizedBox(height: 20.h),

                  // Career & Employment
                  animatedGroup(
                    Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Lang.careerLevel,
                                style: AppFonts.mainText.copyWith(
                                  fontSize: 16.cSp,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              CustomDropDown(
                                selectItem: regVm.careerLevel,
                                label: Lang.careerLevel,
                                items: AppSharedData.careerLevels,
                                onChanged: (val) {
                                  regVm.careerLevel = val;
                                },
                              ),
                            ],
                          ),
                        ),
                        SizedBox(width: 20.w),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                Lang.employmentStatus,
                                style: AppFonts.mainText.copyWith(
                                  fontSize: 16.cSp,
                                ),
                              ),
                              SizedBox(height: 6.h),
                              CustomDropDown(
                                selectItem: regVm.employmentStatus,
                                label: Lang.employmentStatus,
                                items: AppSharedData.employmentStatus,
                                onChanged: (val) {
                                  regVm.employmentStatus = val;
                                },
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    7,
                  ),
                  SizedBox(height: 20.h),

                  // Brief
                  animatedGroup(
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          Lang.brief,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.briefController,
                          hint: Lang.briefHint,
                          maxLines: 5,
                          onValidate: emptyFieldValidator,
                        ),
                      ],
                    ),
                    8,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    Lang.cv,
                    style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                  ),
                  SizedBox(height: 6.h),
                  CustomButtom(
                    color: AppColors.white,
                    hight: 40.h,
                    title:
                        regVm.fileName.isEmpty ? Lang.upload : regVm.fileName,
                    onPressed: () async {
                      await regVm.pickAndReadFile();
                      setState(() {});
                    },
                  ),
                  SizedBox(height: 20.h),

                  // Checkboxes
                  animatedGroup(
                    Column(
                      children: [
                        Row(
                          children: [
                            Checkbox(
                              value: regVm.sendMeEmail,
                              onChanged: (val) {
                                regVm.sendMeEmail = val ?? false;
                                setState(() {});
                              },
                            ),
                            Text(
                              Lang.sendMeEmail,
                              style: AppFonts.hintStyle.copyWith(
                                fontSize: 11.cSp,
                              ),
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Checkbox(
                              value: regVm.immediateStar,
                              onChanged: (val) {
                                regVm.immediateStar = val ?? false;
                                setState(() {});
                              },
                            ),
                            Text(
                              Lang.immediateStart,
                              style: AppFonts.hintStyle.copyWith(
                                fontSize: 12.5.cSp,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    10,
                  ),
                  SizedBox(height: 20.h),

                  // Register Button
                  animatedGroup(
                    CustomButtom(
                      title: Lang.register,
                      onPressed: () async {
                        await regVm.regSeeker();
                      },
                    ),
                    11,
                  ),
                  SizedBox(height: 20.h),

                  // Social Login
                  animatedGroup(
                    Column(
                      children: [
                        Text(
                          Lang.orLoginWith,
                          textAlign: TextAlign.center,
                          style: AppFonts.secMain.copyWith(fontSize: 14.cSp),
                        ),
                        SizedBox(height: 16.cSp),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            BounceInLeft(
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  AppAssets.google,
                                  width: 46.96.w,
                                  height: 42.33.h,
                                ),
                              ),
                            ),
                            SizedBox(width: 16.cSp),
                            BounceInRight(
                              child: GestureDetector(
                                onTap: () {},
                                child: Image.asset(
                                  AppAssets.microsoft,
                                  width: 46.96.w,
                                  height: 42.33.h,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                    12,
                  ),
                  SizedBox(height: 16.cSp),
                  animatedGroup(
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(Lang.alreadyHaveAccount),
                        TextButton(
                          onPressed: () {
                            Navigator.pushReplacementNamed(
                              context,
                              PagesRoute.firstPage,
                            );
                          },
                          child: Text(
                            Lang.login,
                            style: AppFonts.secMain.copyWith(
                              fontSize: 14.cSp,
                              color: AppColors.primary,
                              decoration: TextDecoration.underline,
                              decorationColor: AppColors.primary,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                        ),
                      ],
                    ),
                    13,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
