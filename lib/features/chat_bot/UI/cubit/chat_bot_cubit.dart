import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/chat_bot/UI/cubit/state/chat_bot_state.dart';
import 'package:hireny/features/chat_bot/domain/models/chatboot.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/chat_bot_repo_contract.dart';

@injectable
class ChatBotCubit extends Cubit<ChatBotState> {
  final ChatBootRepo chatBootRepo;
  final List<String> messages = [];
  @factoryMethod
  ChatBotCubit(this.chatBootRepo) : super(InitChatBot());

  void getChatBoot(ChatBootModel chatBootModel) async {
    try {
      emit(LoadingChatBot());
      final result = await chatBootRepo.getChatBoot(chatBootModel);
      switch (result) {
        case null:
          {
            emit(HideLoadingChatBot());
            emit(ErrorChatBot());
          }

        case Success<ChatBootModel>():
          {
            emit(HideLoadingChatBot());
            messages.add(result.response?.message ?? "");
          }
        case Error<ChatBootModel>():
          {
            emit(HideLoadingChatBot());
            emit(ErrorChatBot());
          }
      }
    } catch (e) {
      emit(HideLoadingChatBot());
      emit(ErrorChatBot());
    }
  }
}
