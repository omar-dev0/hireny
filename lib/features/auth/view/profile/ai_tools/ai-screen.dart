import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/ai-content.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/ai_cubit.dart';
import 'package:hireny/features/auth/view/profile/ai_tools/cubit/state/states.dart';
import 'package:hireny/utils/di/di.dart';

class AiScreen extends StatelessWidget {
  const AiScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<AiCubit>(),
      child: BlocConsumer<AiCubit, AIState>(
        builder: (context, state) => AiContent(),
        listener: (context, state) {},
      ),
    );
  }
}
