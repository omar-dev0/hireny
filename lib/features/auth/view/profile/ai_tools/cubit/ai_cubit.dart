import 'dart:io';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/state/states.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../result.dart';

@injectable
class AiCubit extends Cubit<AIState> {
  RepoAuth repoAuth;
  @factoryMethod
  AiCubit(this.repoAuth) : super(AIInitState());

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
      emit(LoadingAiState());
      if (AppSharedData.user is Seeker) {
        Seeker seeker = AppSharedData.user as Seeker;
        if (seeker.cv == null) {
          emit(HideAiState());
          emit(ErrorAiState(error: 'please upload your cv'));
        }
      }
      Seeker seeker = AppSharedData.user as Seeker;
      var result = await repoAuth.generateAndDownloadCoverLetter(
        File(seeker.cv!),
      );
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
}
