import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/app_fonts.dart';
import 'package:hireny/utils/widgets/custom_buttom.dart';
import 'package:lottie/lottie.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';

class VerfyOtpContent extends StatelessWidget {
  const VerfyOtpContent({super.key});

  @override
  Widget build(BuildContext context) {
    ForgetPasswordVM cubit = context.read<ForgetPasswordVM>();
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Column(
            children: [
              Lottie.asset(
                width: MediaQuery.sizeOf(context).width * .9,
                'assets/animations/otp.json',
              ),
              SizedBox(height: 20),
              Text(
                'fill OTP code sent to your email',
                style: AppFonts.secMain.copyWith(fontWeight: FontWeight.w600),
              ),
              SizedBox(height: 20),
              OtpTextField(
                textStyle: TextStyle(color: AppColors.primary, fontSize: 20),
                numberOfFields: 6,
                borderColor: Color(0xFF512DA8),
                borderRadius: BorderRadius.circular(10),
                inputFormatters: [FilteringTextInputFormatter.digitsOnly],
                onCodeChanged: (String? val) {
                  cubit.otp+= val!;
                },
                showFieldAsBox: true,
                keyboardType: TextInputType.number,
                cursorColor: AppColors.primary,
                fieldHeight: 100,
                fieldWidth: 50,
              ),
              SizedBox(height: 20),
              Spacer(),
              CustomButtom(
                title: 'Change Password',
                onPressed: () {
                  cubit.verifyOtp();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
