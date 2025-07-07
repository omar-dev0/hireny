abstract class ServiceApplicationsStates {}

class InitialState extends ServiceApplicationsStates {}

class LoadingState extends ServiceApplicationsStates {}

class SuccessState extends ServiceApplicationsStates {}

class ErrorState extends ServiceApplicationsStates {
  String? message;
  ErrorState(this.message);
}
