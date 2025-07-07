import '../../../result.dart';
import '../model/chat_response.dart';

abstract class ChatRepo{
  Future<Result<ChatResponse>?> getConversations();
  Future<Result<void>?> markRead(int id);
}