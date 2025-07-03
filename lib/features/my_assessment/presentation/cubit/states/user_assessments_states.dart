import '../../../../auth/domain/modules/assessment/assessment.dart';

abstract class UserAssessmentStates {}

class InitUserAssessments extends UserAssessmentStates {}

class LoadingUserAssessments extends UserAssessmentStates {}

class ErrorUserAssessments extends UserAssessmentStates {
  final String? message;
  ErrorUserAssessments({this.message});
}

class SuccessUserAssessments extends UserAssessmentStates {
  List<AssessmentModel>? assessments;
  SuccessUserAssessments({this.assessments});
}

class LoadingAssessment extends UserAssessmentStates {}

class HideLoadingAssessment extends UserAssessmentStates {}
