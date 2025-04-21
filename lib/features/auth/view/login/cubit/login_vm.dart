import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/repo_contract/repo_contract.dart';
import 'package:hireny/features/auth/view/login/cubit/states/login_state.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginVm extends Cubit<LoginState> {
  TextEditingController email = TextEditingController();
  TextEditingController password = TextEditingController();
  RepoAuth repoAuth;
  @factoryMethod
  LoginVm(this.repoAuth) : super(InitState());
}
