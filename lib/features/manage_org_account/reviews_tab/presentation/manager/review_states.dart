abstract class ReviewStates{}
class InitialState extends ReviewStates{}
class LoadingState extends ReviewStates{}
class SuccessState extends ReviewStates{}
class StepChangedState extends ReviewStates {
  final int step;
  StepChangedState(this.step);
}
class ErrorState extends ReviewStates{
  String? message;
  ErrorState(this.message);
}
