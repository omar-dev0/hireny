abstract class UserStates {}

class InitialState extends UserStates {}

class LoadingState extends UserStates {}

class SuccessUpdatedState extends UserStates {}

class ErrorState extends UserStates {
  String? message;
  ErrorState(this.message);
}

class ErrorUpdatedState extends UserStates {
  String? message;
  ErrorUpdatedState(this.message);
}
