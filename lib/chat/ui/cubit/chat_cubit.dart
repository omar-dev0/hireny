import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/chat/domain/model/chat_response.dart';
import 'package:hireny/chat/domain/repo_contract/chat_repo_contract.dart';
import 'package:hireny/chat/ui/cubit/state/chat_state.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@injectable
class ChatCubit extends Cubit<ChatState> {
  final ChatRepo chatRepo;
  ChatResponse? chatResponse;
  @factoryMethod
  ChatCubit(this.chatRepo) : super(InitChat());

  Future<void> getConversations() async {
    try {
      print('getConversations');
      emit(LoadingChat());
      final result = await chatRepo.getConversations();
      switch (result) {
        case null:
          {
            emit(ErrorChat(message: 'Something went wrong'));
          }
        case Success<ChatResponse>():
          {
            chatResponse = result.response;
            emit(SuccessChat(result.response));
          }
        case Error<ChatResponse>():
          {
            emit(ErrorChat(message: result.error));
          }
      }
    } catch (e) {
      emit(ErrorChat(message: e.toString()));
    }
  }

  Future<void> markRead(int id) async {
    try {
      await chatRepo.markRead(id);
    } catch (e) {
      print(e);
    }
  }
}
