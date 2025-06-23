
abstract class LoginState  {}

class InitLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {}

class FailLogin extends LoginState {
  String? error;
  FailLogin({this.error});
}

class ShowRegChoices extends LoginState {}

class ShowSeekerChoicesReg extends LoginState {}

class HideLoading extends LoginState {
}

