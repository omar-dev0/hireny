import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/validation/inputs_validator.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:hireny/utils/widgets/custom_text_field.dart';
import 'package:lottie/lottie.dart';

class VerifyEmailContent extends StatelessWidget {
  const VerifyEmailContent({super.key});

  @override
  Widget build(BuildContext context) {
    final ForgetPasswordVM cubit = context.read<ForgetPasswordVM>();

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Lottie.asset('assets/animations/email.json'),
                  Text(
                    'entery your email to send OTP for it',
                    style: AppFonts.secMain.copyWith(
                      fontWeight: FontWeight.w600,
                    ),
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  CustomTextField(
                    controller: cubit.emailVerfiy,
                    hint: 'Enter Your Email',
                    onValidate: emailValidation,
                  ),
                  SizedBox(height: 20),
                  CustomButtom(
                    title: 'Send OTP',
                    onPressed: () {
                      cubit.forgetPassword();
                    },
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
