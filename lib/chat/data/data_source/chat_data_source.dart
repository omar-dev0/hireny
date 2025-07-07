
import '../../../result.dart';
import '../../domain/model/chat_response.dart';

abstract class ChatDataSource{
  Future<Result<ChatResponse>?> getConversations();
  Future<Result<void>?> markRead(int id);

}