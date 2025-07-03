import 'package:hireny/features/chat_bot/data/data_source/chat_bot_data_source.dart';
import 'package:hireny/features/chat_bot/domain/models/chatboot.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/repo_contract/chat_bot_repo_contract.dart';

@Injectable(as: ChatBootRepo )
class ChatBootRepoImp extends ChatBootRepo {
  ChatBootDataSource chatBootDataSource;
  @factoryMethod
  ChatBootRepoImp(this.chatBootDataSource);
  @override
  Future<Result<ChatBootModel>?> getChatBoot(ChatBootModel chatBootModel) {
    return chatBootDataSource.getChatBoot(chatBootModel);
  }
}