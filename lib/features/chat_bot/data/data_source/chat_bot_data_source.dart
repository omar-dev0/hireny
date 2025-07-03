import '../../../../result.dart';
import '../../domain/models/chatboot.dart';

abstract class ChatBootDataSource {
  Future<Result<ChatBootModel>?> getChatBoot(ChatBootModel chatBootModel);
}
