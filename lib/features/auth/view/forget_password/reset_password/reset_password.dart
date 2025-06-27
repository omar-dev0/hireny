import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/forget_password_vm.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/state/forget_password_state.dart';
import 'package:hireny/features/auth/view/forget_password/reset_password/rest_password_content.dart';
import 'package:hireny/routes/page_route.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/dialogs/error_dialog.dart';

class ResetPassword extends StatelessWidget {
  final String email;
  const ResetPassword({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create:
          (context) => getIt.get<ForgetPasswordVM>()..emailVerfiy.text = email,
      child: BlocConsumer<ForgetPasswordVM, ForgetPasswordState>(
        builder: (context, state) {
          return RestPasswordContent();
        },
        listener: (context, state) {
          if (state is HideForgetPasswordDialogs) {
            Navigator.pop(context);
          }
          if (state is SuccessResetPassword) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pushNamedAndRemoveUntil(
                context,
                PagesRoute.firstPage,
                (val) => false,
              );
            });
            showDialog(
              context: context,
              builder:
                  (_) => SuccessDialog(message: 'Reset password successfully'),
            );
          }
          if (state is FailResetPassword) {
            showDialog(
              context: context,
              builder:
                  (_) => ErrorDialog(
                    message: 'user not found or something went wrong',
                  ),
            );
          }
          if (state is LoadingResetPassword) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }
        },
      ),
    );
  }
}
