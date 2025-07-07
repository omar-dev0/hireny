// part of 'assessment_org_cubit.dart.dart';

class AssessmentOrgStates {}

final class AssessmentInitial extends AssessmentOrgStates {}
final class AssessmentLoading extends AssessmentOrgStates {}

final class AssessmentSuccess extends AssessmentOrgStates {}

final class AssessmentFailure extends AssessmentOrgStates {
  String? message;
  AssessmentFailure(this.message);
}
