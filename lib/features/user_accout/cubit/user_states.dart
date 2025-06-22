abstract class UserStates{}
class InitialState extends UserStates{}
class SuccessLoadingState extends UserStates{}
class ErrorLoadingState extends UserStates{
  String? message;
  ErrorLoadingState(this.message);
}
class SuccessUpdatedState extends UserStates{}
class ErrorUpdatedState extends UserStates{
  String? message;
  ErrorUpdatedState(this.message);
}
