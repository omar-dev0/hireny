import '../../../domain/model/chat_response.dart';

abstract class ChatState {}

class InitChat extends ChatState {}

class LoadingChat extends ChatState {}

class SuccessChat extends ChatState {
  ChatResponse? conversations;
  SuccessChat(this.conversations);
}

class ErrorChat extends ChatState {
  String? message;
  ErrorChat({this.message});
}
