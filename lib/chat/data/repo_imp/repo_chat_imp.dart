import 'package:hireny/chat/domain/model/chat_response.dart';
import 'package:hireny/chat/domain/repo_contract/chat_repo_contract.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../data_source/chat_data_source.dart';

@Injectable(as: ChatRepo)
class ChatRepoImp extends ChatRepo {
  ChatDataSource chatDataSource;
  @factoryMethod
  ChatRepoImp(this.chatDataSource);

  @override
  Future<Result<ChatResponse>?> getConversations() {
    return chatDataSource.getConversations();
  }

  @override
  Future<Result<void>?> markRead(int id) {
    return chatDataSource.markRead(id);
  }
}
