import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/assessment/assessment.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/my_assessment/presentation/cubit/states/user_assessments_states.dart';

import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class UserAssessmentCubit extends Cubit<UserAssessmentStates> {
  RepoAuth _repoAuth;
  @factoryMethod
  UserAssessmentCubit(this._repoAuth) : super(InitUserAssessments());

  Future<void> getUserAssessments() async {
    try {
      emit(LoadingAssessment());
      var res = await _repoAuth.getAssessments();
      switch (res) {
        case null:
          {
            emit(ErrorUserAssessments());
          }
        case Success<List<AssessmentModel>?>():
          {
            AppSharedData.assessments = res.response;
            emit(
              SuccessUserAssessments(assessments: AppSharedData.assessments),
            );
          }

        case Error<List<AssessmentModel>?>():
          {
            emit(ErrorUserAssessments());
          }
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
  }
}
