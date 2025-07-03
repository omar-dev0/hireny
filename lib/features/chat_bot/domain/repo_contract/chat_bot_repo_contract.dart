import '../../../../result.dart';
import '../models/chatboot.dart';

abstract class ChatBootRepo {
  Future<Result<ChatBootModel>?> getChatBoot(ChatBootModel chatBootModel);

}