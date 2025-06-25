import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:animate_do/animate_do.dart';
import 'package:lottie/lottie.dart';

import '../../../../../routes/page_route.dart';
import '../../../../../utils/constants/app_colors.dart';
import '../../../../../utils/constants/dialogs/error_dialog.dart';
import '../../../../../utils/constants/dialogs/loading_dialog.dart';
import '../../../../../utils/constants/dialogs/success_dialog.dart';
import '../../../../../utils/widgets/custom_text_field.dart';
import '../cubit/user_cubit.dart';
import '../cubit/user_states.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword({super.key});

  @override
  State<ChangePassword> createState() => _ChangePasswordState();
}

class _ChangePasswordState extends State<ChangePassword> {
  @override
  Widget build(BuildContext context) {
    final cubit = context.read<UserCubit>();
    final theme = Theme.of(context);

    return BlocListener<UserCubit, UserStates>(
      listener: (context, state) {
        if (state is LoadingState) {
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (_) => LoadingDialog(),
          );
        }

        if (state is SuccessUpdatedState) {
          Navigator.pop(context);
          showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) => const SuccessDialog(),
          );

          Future.delayed(const Duration(seconds: 2), () {
            Navigator.pop(context);
            Navigator.pushNamedAndRemoveUntil(
              context,
              PagesRoute.generalInfo,
                  (route) => false,
            );
          });
        }
        if (state is ErrorUpdatedState) {
          Navigator.pop(context);
          showDialog(
            context: context,
            builder: (_) => ErrorDialog(message: state.message),
          );
          Future.delayed(const Duration(seconds: 3), () {
            if (Navigator.canPop(context)) {
              Navigator.pop(context);
            }
          });
        }
      },
      child: Scaffold(
      backgroundColor: AppColors.white,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_rounded),
          onPressed: () => Navigator.pop(context),
        ),
        title: FadeInDown(
          duration: const Duration(milliseconds: 500),
          child: Text(
            'Change Password',
            style: theme.textTheme.headlineSmall?.copyWith(
              fontWeight: FontWeight.w600,
              color: theme.primaryColor,
            ),
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: SingleChildScrollView(
          child: Form(
            key: cubit.formKey,
            child: Column(
              children: [
            Center(
            child: Lottie.asset(
            'animations/password.json',
              width: 200,
              height: 200,
              repeat: true,
              animate: true,
            ),
          ),
                const SizedBox(height: 24),
                FadeInLeft(
                  duration: const Duration(milliseconds: 500),
                  child: CustomTextField(
                    controller: cubit.oldPasswordController,
                    label: "Current Password",
                    hint: "Enter your current password",
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ),
                const SizedBox(height: 20),
                FadeInLeft(
                  duration: const Duration(milliseconds: 600),
                  child: CustomTextField(
                    controller: cubit.resetPasswordController,
                    label: "New Password",
                    hint: "Create new password",
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    onValidate: (value) => cubit.validatePassword(value),
                  ),
                ),
                const SizedBox(height: 20),
                FadeInLeft(
                  duration: const Duration(milliseconds: 700),
                  child: CustomTextField(
                    controller: cubit.confirmResetPasswordController,
                    label: "Confirm New Password",
                    hint: "Re-enter new password",
                    prefixIcon: const Icon(Icons.lock_outline_rounded),
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                    onValidate: (value) => cubit.validateConfirmPassword(value),
                  ),
                ),
                const SizedBox(height: 32),
                FadeInUp(
                  duration: const Duration(milliseconds: 800),
                  child: SizedBox(
                    width: double.infinity,
                    height: 52,
                    child: ElevatedButton(
                        onPressed: () async {
                          if (cubit.formKey.currentState!.validate()) {
                            FocusScope.of(context).unfocus(); // hide keyboard
                            await cubit.changePassword();
                          }
                        },

                      style: ElevatedButton.styleFrom(
                        backgroundColor: theme.primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 0,
                      ),
                      child: Text(
                        "Update Password",
                        style: theme.textTheme.bodyLarge?.copyWith(
                          fontWeight: FontWeight.w600,
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(height: 16),
                FadeInUp(
                  duration: const Duration(milliseconds: 900),
                  child: TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text(
                      "Cancel",
                      style: theme.textTheme.bodyLarge?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      )
    );
  }
}
