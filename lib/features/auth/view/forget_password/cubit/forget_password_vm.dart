import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/forget_password/cubit/state/forget_password_state.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ForgetPasswordVM extends Cubit<ForgetPasswordState> {
  final TextEditingController emailVerfiy = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController confirmPassword = TextEditingController();
  String otp = '';
  final RepoAuth authRepo;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final GlobalKey<FormState> passwordChangeKey = GlobalKey<FormState>();
  @factoryMethod
  ForgetPasswordVM(this.authRepo) : super(InitForgetPassword());

  Future<void> forgetPassword() async {
    if (formKey.currentState!.validate()) {
      try {
        emit(LoadingForgetPassword());
        var result = await authRepo.sendOtp(emailVerfiy.text);
        switch (result) {
          case null:
            {
              emit(HideForgetPasswordDialogs());
              emit(FailForgetPassword());
            }
          case Success<void>():
            {
              emit(HideForgetPasswordDialogs());
              emit(SuccessForgetPassword());
            }
          case Error<void>():
            {
              emit(HideForgetPasswordDialogs());
              emit(FailForgetPassword());
            }
        }
      } catch (e) {
        emit(HideForgetPasswordDialogs());
        emit(FailForgetPassword());
      }
    }
  }

  Future<void> verifyOtp() async {
    try {
      emit(LoadingVerifyOtp());
      var result = await authRepo.verifyOtp(emailVerfiy.text, otp);
      switch (result) {
        case null:
          {
            emit(HideForgetPasswordDialogs());
            emit(FailVerifyOtp());
          }
        case Success<void>():
          {
            emit(HideForgetPasswordDialogs());
            emit(SuccessVerifyOtp());
          }
        case Error<void>():
          {
            emit(HideForgetPasswordDialogs());
            emit(FailVerifyOtp());
          }
      }
    } catch (e) {
      emit(HideForgetPasswordDialogs());
      emit(FailVerifyOtp());
    }
  }

  Future<void> changePassword() async {
    if (passwordChangeKey.currentState!.validate()) {
      try {
        emit(LoadingResetPassword());
        var result = await authRepo.resetPassword(
          emailVerfiy.text,
          password.text,
        );
        switch (result) {
          case null:
            {
              emit(HideForgetPasswordDialogs());
              emit(FailResetPassword());
            }
          case Success<void>():
            {
              emit(HideForgetPasswordDialogs());
              emit(SuccessResetPassword());
            }
            throw UnimplementedError();
          case Error<void>():
            {
              emit(HideForgetPasswordDialogs());
              emit(FailResetPassword());
            }
        }
      } catch (e) {
        emit(HideForgetPasswordDialogs());
        emit(FailResetPassword());
      }
    }
  }
}
