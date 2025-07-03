import '../../../../../../auth/domain/modules/assessment/assessment.dart';

abstract class AssissmentState {}

class InitAssissment extends AssissmentState {}

class LoadingSubmitAssessment extends AssissmentState {}

class SuccessSubmitAssessment extends AssissmentState {}

class ErrorSubmitAssessment extends AssissmentState {}

class HideLoadingSubmitAssessment extends AssissmentState {}

class OnTimeFinished extends AssissmentState {}
