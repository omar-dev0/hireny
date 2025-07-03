import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/utils/di/di.dart';

import '../../../utils/constants/dialogs/error_dialog.dart';
import 'chat_boot_screen_content.dart';
import 'cubit/chat_bot_cubit.dart';
import 'cubit/state/chat_bot_state.dart';

class ChatBootScreen extends StatelessWidget {
  const ChatBootScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ChatBotCubit>(),
      child: BlocConsumer<ChatBotCubit, ChatBotState>(
        builder: (context, state) => ChatBootScreenContent(),
        listener: (context, state) {
          if (state is ErrorChatBot) {
            showDialog(
              context: context,
              builder:
                  (_) =>
                      ErrorDialog(message: 'can\'t connect with chatboot =('),
            );
          }
          if (state is HideLoadingChatBot) {
            Navigator.pop(context);
          }
          if (state is LoadingChatBot) {
            showDialog(
              context: context,
              builder: (_) => const Center(child: CircularProgressIndicator()),
            );
          }
        },
      ),
    );
  }
}
