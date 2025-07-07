import 'package:bloc/bloc.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/org_assessment/domain/usecase/get_assessments.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/domain/modules/seeker/seeker.dart';
import '../../data/models/assessment_model.dart';
import 'assessment_org_states.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../../../result.dart';

@injectable
class AssessmentOrgCubit extends Cubit<AssessmentOrgStates> {
  final GetAssessments getAssessments;
  String? orgName;

  @factoryMethod
  AssessmentOrgCubit(this.getAssessments) : super(AssessmentInitial());

  Future<void> getAssessment() async {
    debugPrint("===========? call");
    emit(AssessmentLoading());

    if (AppSharedData.assessmentsOrg.isNotEmpty) {
      emit(AssessmentSuccess());
      return;
    }

    final result = await getAssessments.call();

    if (result is Success) {
      final assessments = result.response as List<AssessmentResponse>;

      AppSharedData.assessmentsOrg.clear();
      AppSharedData.assessmentsOrg.addAll(assessments);

      emit(AssessmentSuccess());
    } else if (result is Error) {
      debugPrint('Error getting assessments: ${result.error}');
      emit(AssessmentFailure(result.error));
    }
  }

}
