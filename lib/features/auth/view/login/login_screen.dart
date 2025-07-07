import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/view/login/cubit/login_vm.dart';
import 'package:hireny/features/auth/view/login/cubit/state.dart';
import 'package:hireny/features/auth/view/login/login_content.dart';
import 'package:hireny/utils/constants/app_colors.dart';
import 'package:hireny/utils/constants/dialogs/loading_dialog.dart';
import 'package:hireny/utils/constants/dialogs/success_dialog.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../routes/page_route.dart';
import '../../../../utils/constants/dialogs/error_dialog.dart';
import '../../../../utils/lang/lang.dart';
import '../widgets/choice_widget.dart';

class LoginScreen extends StatelessWidget {
  LoginScreen({super.key});
  LoginVm loginVm = getIt.get<LoginVm>();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => loginVm,
      child: BlocConsumer<LoginVm, LoginState>(
        listener: (context, state) {
          final loginVm = context.read<LoginVm>();
          if (state is ShowRegChoices) {
            showDialog(
              context: context,
              builder:
                  (_) => ChoiceDialog(
                    message: Lang.register,
                    button1Text: Lang.jobSeeker,
                    button2Text: Lang.organization,
                    iconButton1: Icon(Icons.person, color: AppColors.white),
                    iconButton2: Icon(Icons.home, color: AppColors.primary),
                    onPressButton1: () {
                      AppSharedData.user = Seeker();
                      loginVm.showSeekerChoicesReg();
                    },
                    onPressButton2: () {
                      AppSharedData.user = OrgAdmin();
                      loginVm.showOrgChoicesReg();
                    },
                  ),
            );
          }
          if (state is ShowSeekerChoicesReg) {
            showDialog(
              context: context,
              builder:
                  (_) => ChoiceDialog(
                    message: '',
                    button1Text: Lang.autoFillData,
                    button2Text: Lang.manualFillData,
                    iconButton1: Icon(Icons.rocket, color: AppColors.white),
                    iconButton2: Icon(Icons.edit, color: AppColors.primary),
                    onPressButton1: ()  {
                       loginVm.autoFillSeeker();
                    },
                    onPressButton2: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        PagesRoute.reg,
                        arguments: {'isOrg': false},
                      );
                    },
                  ),
            );
          }

          if (state is ShowOrgChoicesReg) {
            showDialog(
              context: context,
              builder:
                  (_) => ChoiceDialog(
                    message: '',
                    button1Text: Lang.autoFillData,
                    button2Text: Lang.manualFillData,
                    iconButton1: Icon(Icons.rocket, color: AppColors.white),
                    iconButton2: Icon(Icons.edit, color: AppColors.primary),
                    onPressButton1: ()  {
                       loginVm.autoFillOrg();
                    },
                    onPressButton2: () {
                      Navigator.pop(context);
                      Navigator.pushReplacementNamed(
                        context,
                        PagesRoute.reg,
                        arguments: {'isOrg': true},
                      );
                    },
                  ),
            );
          }
          if (state is CVLoadedSuccessfully){
            Navigator.pushReplacementNamed(
              context,
              PagesRoute.reg,
              arguments: {
                'isOrg': false,
                'user': {'user': state.seeker, 'cv': loginVm.file?.path},
              },
            );
          }
          if (state is ProfLoadedSuccessfully) {
            Navigator.pushNamedAndRemoveUntil(
              context,
              PagesRoute.reg,
              (route) => false,
              arguments: {
                'isOrg': true,
                'user': {'user': state.org, 'cv': loginVm.file?.path},
              },
            );
          }

          if (state is HideLoading) {
            Navigator.pop(context);
          }
          if (state is LoadingLogin) {
            showDialog(
              context: context,
              barrierDismissible: false,
              builder: (_) => LoadingDialog(),
            );
          }
          if (state is SuccessLogin) {
            Future.delayed(Duration(seconds: 2), () {
              Navigator.pop(context);
              Navigator.pushNamedAndRemoveUntil(
                context,
                PagesRoute.mainScreen,
                (route) => false,
              );
            });
            showDialog(context: context, builder: (context) => SuccessDialog());
          }
          if (state is FailLogin) {
            showDialog(
              context: context,
              builder: (context) => ErrorDialog(message: state.error),
            );
          }
        },

        builder: (context, state) => LoginContent(),
      ),
    );
  }
}
