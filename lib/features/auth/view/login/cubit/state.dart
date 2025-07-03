import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';

abstract class LoginState {}

class InitLogin extends LoginState {}

class LoadingLogin extends LoginState {}

class SuccessLogin extends LoginState {}

class FailLogin extends LoginState {
  String? error;
  FailLogin({this.error});
}

class ShowRegChoices extends LoginState {}

class ShowSeekerChoicesReg extends LoginState {}

class HideLoading extends LoginState {}

class CVLoadedSuccessfully extends LoginState {
  Seeker? seeker;
  CVLoadedSuccessfully({this.seeker});
}

class FailLoadedCV extends LoginState {}
