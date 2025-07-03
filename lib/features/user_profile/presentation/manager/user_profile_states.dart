abstract class UserProfileStates {}

class InitialState extends UserProfileStates {}

class SuccessLoadingState extends UserProfileStates {}

class ErrorLoadingState extends UserProfileStates {
  String? message;
  ErrorLoadingState(this.message);
}
