import '../../../domain/models/chatboot.dart';

abstract class ChatBotState {}

class InitChatBot extends ChatBotState {}

class LoadingChatBot extends ChatBotState {}

class ErrorChatBot extends ChatBotState {}

class SuccessChatBot extends ChatBotState {
  ChatBootModel? chatBootModel;
  SuccessChatBot({this.chatBootModel});
}

class HideLoadingChatBot extends ChatBotState {}
