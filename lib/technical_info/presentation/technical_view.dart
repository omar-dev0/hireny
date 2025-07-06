import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/technical_info/presentation/manager/technical_info_cubit.dart';
import 'package:hireny/technical_info/presentation/widgets/technicalBOdy.dart';
import 'package:hireny/utils/widgets/custome_appbar_drawer.dart';

import '../../core/widgets/sideBar.dart';
import '../../routes/page_route.dart';
import '../../utils/constants/dialogs/error_dialog.dart';
import '../../utils/constants/dialogs/loading_dialog.dart';
import '../../utils/constants/dialogs/success_dialog.dart';
import '../../utils/di/di.dart';

class TechnicalInfoView extends StatelessWidget {
  const TechnicalInfoView({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScreen(
      title: "Technical Info",
      drawer: SideBarScreen(currentRoute: PagesRoute.techInfo),
      body: BlocProvider(
        create: (_) => getIt<TechnicalInfoCubit>()..getTechInfo(),
        child: BlocListener<TechnicalInfoCubit, TechnicalInfoState>(
          listener: (context, state) {

            if (state is TechnicalInfoSuccessDeleted ||state is TechnicalInfoSuccessUpdated) {
              // Navigator.pop(context);
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (context) => const SuccessDialog(),
              );

              Future.delayed(const Duration(seconds: 2), () {
                Navigator.pop(context);
              });
            }

            if (state is TechnicalInfoFailure) {
              // Navigator.pop(context);
              showDialog(
                context: context,
                builder: (_) {
                  print(state.message);
                  return ErrorDialog(message: state.message);
                }
              );
            }
          },
          child: Technicalbody(),
        ),
      ),
    );
  }
}
