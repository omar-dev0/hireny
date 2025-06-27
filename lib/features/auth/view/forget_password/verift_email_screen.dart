import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/features/auth/view/forget_password/verify_email_content.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import 'cubit/state/forget_password_state.dart';

class VeriftEmailScreen extends StatelessWidget {
  VeriftEmailScreen({super.key});

  final ForgetPasswordVM cubit = getIt.get<ForgetPasswordVM>();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => cubit,
      child: BlocConsumer<ForgetPasswordVM, ForgetPasswordState>(
        builder: (context, state) {
          return VerifyEmailContent();
        },
        listener: (context, state) {
          ForgetPasswordVM forgetPasswordVM = context.read<ForgetPasswordVM>();
          if (state is HideForgetPasswordDialogs) {
            Navigator.pop(context);
          }
          if (state is LoadingForgetPassword) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }
          if (state is SuccessForgetPassword) {
            Future.delayed(Duration(seconds: 1), () {
              Navigator.pushReplacementNamed(
                context,
                PagesRoute.otpScreen,
                arguments: forgetPasswordVM.emailVerfiy.text,
              );
            });
            showDialog(
              context: context,
              builder: (_) => SuccessDialog(message: 'email send successfully'),
            );
          }

          if (state is FailForgetPassword) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'some thing went wrong'),
            );
          }
        },
      ),
    );
  }
}
