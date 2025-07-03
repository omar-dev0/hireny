import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/state/forget_password_state.dart';
import 'package:hireny/features/auth/view/forget_password/verfy_otp/verfy_otp_content.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/dialogs/loading_dialog.dart';
import '../../../../../utils/constants/dialogs/success_dialog.dart';

class VerfyOtp extends StatelessWidget {
  final String email;
  const VerfyOtp({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt.get<ForgetPasswordVM>()..emailVerfiy.text = email,
      child: BlocConsumer<ForgetPasswordVM, ForgetPasswordState>(
        builder: (context, state) => VerfyOtpContent(),
        listener: (context, state) {
          ForgetPasswordVM vm = context.read<ForgetPasswordVM>();
          if (state is LoadingVerifyOtp) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }
          if (state is SuccessVerifyOtp) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushReplacementNamed(
                context,
                PagesRoute.resetPassword,
                arguments: vm.emailVerfiy.text,
              );
            });
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(message: 'Otp verified successfully'),
            );
          }

          if (state is FailVerifyOtp) {
            showDialog(
              context: context,
              builder: (_) => ErrorDialog(message: 'Invalid otp'),
            );
          }
          if (state is HideForgetPasswordDialogs) {
            Navigator.pop(context);
          }
        },
      ),
    );
  }
}
