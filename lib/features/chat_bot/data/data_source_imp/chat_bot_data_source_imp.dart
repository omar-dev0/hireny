import 'package:hireny/features/chat_bot/data/api/api_chatboot_manger.dart';
import 'package:hireny/features/chat_bot/domain/models/chatboot.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../data_source/chat_bot_data_source.dart';

@Injectable(as: ChatBootDataSource)
class ChatBootDataSourceImp extends ChatBootDataSource {
  ChatBootApiManger chatBootApiManger;
  @factoryMethod
  ChatBootDataSourceImp(this.chatBootApiManger);
  @override
  Future<Result<ChatBootModel>?> getChatBoot(ChatBootModel chatBootModel) {
    return chatBootApiManger.getChatBoot(chatBootModel);
  }
}
