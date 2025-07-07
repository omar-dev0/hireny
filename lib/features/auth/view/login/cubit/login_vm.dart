import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/auto_fill/auto_fill_org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/login/cubit/state.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';
import 'dart:io';
import 'package:file_picker/file_picker.dart';

import '../../../../../result.dart';
import '../../../../../utils/data_shared/app_shared_data.dart';
import '../../../domain/modules/auto_fill/autofill_seeker.dart';

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

  Future<void> loadAndParseCv() async {
    emit(LoadingLogin());
    _requestStoragePermission();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      emit(HideLoading());
      return;
    }
    if (result.files.isNotEmpty) {
      emit(HideLoading());
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
    emit(ShowOrgChoicesReg());
  }

  void showOrgChoicesReg() {
    emit(HideLoading());
    emit(ShowOrgChoicesReg());
  }

  Future<void> login() async {
    if (formKey.currentState!.validate()) {
      emit(LoadingLogin());
      try {
        Result<void> result = await _repoAuth.login(email.text, password.text);
        debugPrint(
          "✅ ServiceOrgCubit created ${AppSharedData.user?.firstName}",
        );

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

  Future<void> autoFillSeeker() async {
    try {
      await loadAndParseCv();
      if (file == null) {
        return;
      }
      var responseResult = await _repoAuth.extractFromSeekerCV(file!);
      switch (responseResult) {
        case null:
          {
            emit(HideLoading());
            emit(FailLoadedCV());
          }
        case Success<AutoFillSeeker?>():
          {
            emit(HideLoading());
            emit(CVLoadedSuccessfully(seeker: responseResult.response));
          }
        case Error<AutoFillSeeker?>():
          {
            emit(HideLoading());
            emit(FailLoadedCV());
          }
      }
    } catch (e) {
      emit(HideLoading());
      emit(FailLoadedCV());
    }
  }

  Future<void> autoFillOrg() async {
    try {
      await loadAndParseCv();
      if (file == null) {
        return;
      }
      var responseResult = await _repoAuth.extractFromOrgProf(file!);
      switch (responseResult) {
        case null:
          {
            emit(HideLoading());
            emit(FailLoadedCV());
          }
        case Success<AutoFillOrg?>():
          {
            emit(HideLoading());
            emit(ProfLoadedSuccessfully(org: responseResult.response));
          }
        case Error<AutoFillOrg?>():
          {
            emit(HideLoading());
            emit(FailLoadedCV());
          }
      }
    } catch (e) {
      emit(HideLoading());
      emit(FailLoadedCV());
    }
  }
}
