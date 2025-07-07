import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/state/states.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../../../result.dart';

@injectable
class AiCubit extends Cubit<AIState> {
  RepoAuth repoAuth;
  File? file;
  @factoryMethod
  AiCubit(this.repoAuth) : super(AIInitState());
  Future<void> loadAndParseCv() async {
    emit(LoadingAiState());
    _requestStoragePermission();
    FilePickerResult? result = await FilePicker.platform.pickFiles(
      type: FileType.custom,
      allowedExtensions: ['pdf'],
    );
    if (result == null) {
      emit(HideAiState());
      return;
    }
    if (result.files.isNotEmpty) {
      emit(HideAiState());
      file = File(result.files.single.path!);
    }
  }

  Future<void> generateAndDownloadResume() async {
    try {
      emit(LoadingAiState());
      var result = await repoAuth.generateAndDownloadResume();
      switch (result) {
        case null:
          {
            emit(HideAiState());
            emit(ErrorAiState());
          }
        case Success<void>():
          {
            emit(HideAiState());
            emit(SuccessAiState());
          }
        case Error<void>():
          {
            emit(HideAiState());
            emit(ErrorAiState());
          }
      }
    } catch (e) {
      emit(HideAiState());
      emit(ErrorAiState());
    }
  }

  Future<void> geneateAndDownloadCoverLetter() async {
    try {
      await loadAndParseCv();
      if (file == null) {
        emit(HideAiState());
        emit(ErrorAiState(error: 'please select a file'));
        return;
      }
      emit(LoadingAiState());
      var result = await repoAuth.generateAndDownloadCoverLetter(file!);
      switch (result) {
        case null:
          {
            emit(HideAiState());
            emit(ErrorAiState(error: 'some thing went wrong'));
          }
        case Success<void>():
          {
            emit(HideAiState());
            emit(SuccessAiState());
          }
        case Error<void>():
          {
            emit(HideAiState());
            emit(ErrorAiState(error: 'some thing went wrong'));
          }
      }
    } catch (e) {
      emit(HideAiState());
      emit(ErrorAiState(error: 'some thing went wrong'));
    }
  }

  Future<bool> _requestStoragePermission() async {
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
    }
    return status.isGranted;
  }
}
