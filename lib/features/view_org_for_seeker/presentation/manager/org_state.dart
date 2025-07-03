abstract class OrgStates {}

class InitialState extends OrgStates {}

class LoadingState extends OrgStates {}

class SuccessState extends OrgStates {}

class ErrorState extends OrgStates {
  String? message;
  ErrorState(this.message);
}
