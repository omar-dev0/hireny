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

class RegOrgContent extends StatefulWidget {
  const RegOrgContent({super.key});

  @override
  State<RegOrgContent> createState() => _RegOrgContentState();
}

class _RegOrgContentState extends State<RegOrgContent> {
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
                          Lang.regOrgTitle,
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
                          Lang.adminFirstName,
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
                          Lang.adminLastName,
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
                          Lang.orgName,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.orgName,
                          hint: Lang.orgNameHint,
                          onValidate: emptyFieldValidator,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.orgCeo,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          controller: regVm.orgCeo,
                          hint: Lang.orgCeoHint,
                          onValidate: emptyFieldValidator,
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.industry,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomDropDown(
                          selectItem: regVm.industry,
                          label: Lang.industry,
                          items: AppSharedData.industries,
                          onChanged: (val) {
                            setState(() {
                              regVm.industry = val;
                            });
                          },
                        ),
                        SizedBox(height: 20.h),
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
                                      AppSharedData.countryCityData[regVm
                                          .country] ??
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
                        Row(
                          children: [
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    Lang.orgSize,
                                    style: AppFonts.mainText.copyWith(
                                      fontSize: 16.cSp,
                                    ),
                                  ),
                                  SizedBox(height: 6.h),
                                  CustomDropDown(
                                    selectItem: regVm.orgSize,
                                    items: AppSharedData.organizationSizes,
                                    onChanged: (val) {
                                      setState(() {
                                        regVm.orgSize = val;
                                      });
                                    },
                                  ),
                                ],
                              ),
                            ),
                            SizedBox(width: 20.w),
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
                                    regVm.dob = "${regVm.date!.year}";
                                  }
                                  setState(() {});
                                },
                                child: DateWidget(
                                  content: regVm.dob,
                                  label: Lang.startOrgDate,
                                ),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 20.h),
                        Text(
                          Lang.phone,
                          style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                        ),
                        SizedBox(height: 6.h),
                        CustomTextField(
                          onValidate: emptyFieldValidator,
                          controller: regVm.phone,
                          keyboardType: TextInputType.phone,
                          hint: Lang.phoneHint,
                        ),
                        SizedBox(height: 6.cSp),
                        Text(
                          Lang.phoneNote,
                          style: AppFonts.hintStyle.copyWith(fontSize: 11.cSp),
                        ),
                      ],
                    ),
                    4,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    Lang.orgWebsiteLink,
                    style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                  ),
                  SizedBox(height: 6.h),
                  CustomTextField(
                    controller: regVm.websiteLink,
                    hint: Lang.jobTitleHint,
                    onValidate: emptyFieldValidator,
                  ),
                  SizedBox(height: 20.h),
                  Text(
                    Lang.orgProf,
                    style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                  ),
                  SizedBox(height: 6.w),
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
                        await regVm.regOrg();
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
