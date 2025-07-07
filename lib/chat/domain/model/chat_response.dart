class ChatResponse {
  final int comparisonId;
  final List<Conversation> conversations;

  ChatResponse({
    required this.comparisonId,
    required this.conversations,
  });

  factory ChatResponse.fromJson(Map<String, dynamic> json) {
    return ChatResponse(
      comparisonId: json['comparisonId'],
      conversations: (json['conversations'] as List)
          .map((e) => Conversation.fromJson(e))
          .toList(),
    );
  }
}

class Conversation {
  final int participantId;
  final String participantName;
  final String participantRole;
  final String participantPhoto;
  final List<Message> messages;
  final int unreadCount;

  Conversation({
    required this.participantId,
    required this.participantName,
    required this.participantRole,
    required this.participantPhoto,
    required this.messages,
    required this.unreadCount,
  });

  factory Conversation.fromJson(Map<String, dynamic> json) {
    return Conversation(
      participantId: json['participantId'],
      participantName: json['participantName'],
      participantRole: json['participantRole'],
      participantPhoto: json['participantPhoto'],
      messages: (json['messages'] as List)
          .map((e) => Message.fromJson(e))
          .toList(),
      unreadCount: json['unreadCount'],
    );
  }
}

class Message {
  final int id;
  final String content;
  final DateTime createdAt;
  final int sender;
  final int receiver;

  Message({
    required this.id,
    required this.content,
    required this.createdAt,
    required this.sender,
    required this.receiver,
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json['id'],
      content: json['content'],
      createdAt: DateTime.parse(json['created_at']),
      sender: json['sender'],
      receiver: json['receiver'],
    );
  }
}
