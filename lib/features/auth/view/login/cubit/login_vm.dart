import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/login/cubit/state.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../../../result.dart';

@injectable
class LoginVm extends Cubit<LoginState> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  GlobalKey<FormState> formKey = GlobalKey<FormState>();
  RepoAuth _repoAuth;
  bool remmberMe = true;
  File? file;
  @factoryMethod
  LoginVm(this._repoAuth) : super(InitLogin());

  Future<void> pickAndReadCVFile() async {
    emit(LoadingLogin());
    _requestStoragePermission();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    emit(HideLoading());
    if (result != null && result.files.isNotEmpty) {
      file = File(result.files.single.path!);
    }
  }

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }

  void showRegChoices() {
    emit(ShowRegChoices());
  }

  void showSeekerChoicesReg() {
    emit(HideLoading());
    emit(ShowSeekerChoicesReg());
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingLogin());
      try {
        Result<void> result = await _repoAuth.login(email.text, password.text);
        if (result is Success) {
          emit(HideLoading());
          emit(SuccessLogin());
        } else {
          emit(HideLoading());
          emit(FailLogin(error: 'email or password is wrong'));
        }
      } catch (e) {
        emit(HideLoading());
        emit(FailLogin(error: 'email or password is wrong'));
      }
    }
  }
}
