import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/chat/ui/screens/chat.dart';
import 'package:hireny/utils/di/di.dart';

import '../cubit/chat_cubit.dart';
import '../cubit/state/chat_state.dart';

class ChatBlocProivder extends StatelessWidget {
  const ChatBlocProivder({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt.get<ChatCubit>()..getConversations(),
      child: BlocBuilder<ChatCubit, ChatState>(
        builder: (context, state) {
          var cubit = context.read<ChatCubit>();
          if (state is LoadingChat) {
            return Scaffold(body: Center(child: CircularProgressIndicator()));
          }
          if (state is ErrorChat) {
            return Scaffold(body: Center(child: Text(state.message ?? '')));
          }
          return ChatScreen(chatResponse: cubit.chatResponse);
        },
      ),
    );
  }
}
