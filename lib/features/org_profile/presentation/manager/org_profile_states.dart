abstract class OrgProfileStates {}

class InitialState extends OrgProfileStates {}

class LoadingState extends OrgProfileStates {}

class SuccessState extends OrgProfileStates {}

class ErrorState extends OrgProfileStates {
  String? message;
  ErrorState(this.message);
}
