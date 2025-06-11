import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:hireny/features/auth/view/login/cubit/login_vm.dart';
import 'package:hireny/features/auth/view/widgets/choice_widget.dart';
import 'package:hireny/utils/app_assets.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/extensions/font_size.dart';
import 'package:hireny/utils/lang/lang.dart';
import 'package:hireny/utils/validation/inputs_validator.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';

import 'cubit/state.dart';

class LoginContent extends StatefulWidget {
  const LoginContent({super.key});

  @override
  State<LoginContent> createState() => _LoginContentState();
}

class _LoginContentState extends State<LoginContent> {
  @override
  Widget build(BuildContext context) {
    LoginVm loginVm = BlocProvider.of<LoginVm>(context);
    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Center(
              child: Form(
                key: loginVm.formKey,
                child: FadeInUp(
                  duration: const Duration(milliseconds: 700),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        Lang.loginTitle,
                        style: AppFonts.mainText.copyWith(fontSize: 24.cSp),
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 12.cSp),
                      Text(
                        Lang.loginSubTitle,
                        style: AppFonts.secMain,
                        textAlign: TextAlign.center,
                      ),
                      Text(
                        Lang.loginSubTitle2,
                        style: AppFonts.secMain,
                        textAlign: TextAlign.center,
                      ),
                      SizedBox(height: 24.cSp),
                      Image.asset(
                        AppAssets.loginImage,
                        width: 190.w,
                        height: 190.w,
                      ),
                      Text(
                        Lang.email,
                        style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                      ),
                      CustomTextField(
                        controller: loginVm.email,
                        hint: Lang.emailHint,
                        onValidate: emailValidation,
                      ),
                      SizedBox(height: 16.cSp),
                      Text(
                        Lang.password,
                        style: AppFonts.mainText.copyWith(fontSize: 16.cSp),
                      ),
                      CustomTextField(
                        isPassword: true,
                        hint: Lang.passwordHint,
                        onValidate: passwordValidator,
                        controller: loginVm.password,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          TextButton(
                            onPressed: () {},
                            child: Text(
                              Lang.forgetPassword,
                              style: AppFonts.secMain.copyWith(
                                fontSize: 14.cSp,
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              Checkbox(
                                value: loginVm.remmberMe,
                                onChanged: (value) {
                                  loginVm.remmberMe = value ?? false;
                                  AppSharedData.rememberMe = loginVm.remmberMe;
                                  setState(() {});
                                },
                              ),
                              Text(
                                Lang.rememmberMe,
                                style: AppFonts.secMain.copyWith(
                                  fontSize: 14.cSp,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                      SizedBox(height: 24.cSp),
                      ZoomIn(
                        // <- Animated Login Button
                        duration: const Duration(milliseconds: 500),
                        child: CustomButtom(
                          title: Lang.login,
                          onPressed: () async{
                           await loginVm.login();
                          },
                        ),
                      ),
                      SizedBox(height: 16.cSp),
                      Text(
                        textAlign: TextAlign.center,
                        Lang.orLoginWith,
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
                      SizedBox(height: 16.cSp),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(Lang.dontHaveAccount),
                          TextButton(
                            onPressed: () {
                              loginVm.showRegChoices();
                            },
                            child: Text(
                              Lang.register,
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
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
