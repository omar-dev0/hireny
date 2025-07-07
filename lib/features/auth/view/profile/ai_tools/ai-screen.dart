import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/ai-content.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/ai_cubit.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/state/states.dart';
import 'package:hireny/utils/constants/dialogs/error_dialog.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../../../utils/constants/dialogs/loading_dialog.dart';
import '../../../../../utils/constants/dialogs/success_dialog.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AiCubit>(),
      child: BlocConsumer<AiCubit, AIState>(
        builder: (context, state) => AiContent(),
        listener: (context, state) {
          if (state is ErrorAiState) {
            showDialog(
              context: context,
              builder:
                  (_) => ErrorDialog(
                    message: 'some thing went wrong or you don\'t uplode any file',
                  ),
            );
          }
          if (state is SuccessAiState) {
            showDialog(
              context: context,
              builder: (_) => SuccessDialog(message: "success"),
            );
          }
          if (state is HideAiState) {
            Navigator.pop(context);
          }
          if (state is LoadingAiState) {
            showDialog(context: context, builder: (_) => LoadingDialog());
          }
        },
      ),
    );
  }
}
