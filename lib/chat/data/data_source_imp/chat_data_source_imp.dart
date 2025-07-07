import 'package:hireny/chat/data/api/api_manger.dart';
import 'package:hireny/chat/data/data_source/chat_data_source.dart';
import 'package:hireny/chat/domain/model/chat_response.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: ChatDataSource)
class ChatDataSourceImp extends ChatDataSource{
  ChatApiManger chatApiManger;
  @factoryMethod
  ChatDataSourceImp(this.chatApiManger);
  @override
  Future<Result<ChatResponse>?> getConversations() {
    return chatApiManger.getConversations();
  }

  @override
  Future<Result<void>?> markRead(int id) {
    return chatApiManger.markRead(id);

  }
}