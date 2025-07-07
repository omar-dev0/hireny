import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';

import '../../../domain/modules/auto_fill/auto_fill_org_admin.dart';
import '../../../domain/modules/auto_fill/autofill_seeker.dart';

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
class ShowOrgChoicesReg extends LoginState {}

class HideLoading extends LoginState {}

class CVLoadedSuccessfully extends LoginState {
  AutoFillSeeker? seeker;
  CVLoadedSuccessfully({this.seeker});
}

class ProfLoadedSuccessfully extends LoginState{
  AutoFillOrg? org;
  ProfLoadedSuccessfully({this.org});
}

class FailLoadedCV extends LoginState {}
