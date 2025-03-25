import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/login/cubit/login_vm.dart';
import 'package:hireny/features/auth/view/login/cubit/states/login_state.dart';
import 'package:hireny/features/auth/view/login/login_content.dart';
import 'package:hireny/utils/di/di.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  LoginVm loginVm = getIt.get<LoginVm>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => loginVm,
      child: BlocConsumer<LoginVm, LoginState>(
        listener: (context, state) {},
        builder: (context, state) => LoginContent(),
      ),
    );
  }
}

//bloc
// injectable
