import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/validation/inputs_validator.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:lottie/lottie.dart';

import '../../../../../utils/widgets/custom_text_field.dart';

class RestPasswordContent extends StatelessWidget {
  const RestPasswordContent({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordVM forgetPasswordVM = context.read<ForgetPasswordVM>();
    return Scaffold(
      body: Form(
        key: forgetPasswordVM.passwordChangeKey,
        child: SafeArea(
          child: Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Lottie.asset(
                  'assets/animations/reset_password.json',
                  width: MediaQuery.sizeOf(context).width * .5,
                ),
                Text(
                  'Reset Password',
                  style: AppFonts.secMain.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 20,
                  ),
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Enter new password',
                  controller: forgetPasswordVM.password,
                  isPassword: true,
                  onValidate: passwordValidator,
                ),
                SizedBox(height: 20),
                CustomTextField(
                  hint: 'Confirm new password',
                  isPassword: true,
                  controller: forgetPasswordVM.confirmPassword,
                  onValidate: (val) {
                    if (val != forgetPasswordVM.password.text) {
                      return 'password not match';
                    }
                    return null;
                  },
                ),
                SizedBox(height: 20),
                CustomButtom(
                  title: 'Reset Password',
                  onPressed: () {
                    forgetPasswordVM.changePassword();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
