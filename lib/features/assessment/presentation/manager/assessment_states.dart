abstract class AssessmentStates {}

class InitialState extends AssessmentStates {}

class LoadingState extends AssessmentStates {}

class SuccessState extends AssessmentStates {}

class StepChangedState extends AssessmentStates {
  final int step;
  StepChangedState(this.step);
}

class ErrorState extends AssessmentStates {
  String? message;
  ErrorState(this.message);
}
