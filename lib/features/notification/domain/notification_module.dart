class AppNotification {
  final int id;
  final String message;
  final String title;
  final bool isRead;
  final DateTime createdAt;
  final int user;

  AppNotification({
    required this.id,
    required this.message,
    required this.title,
    required this.isRead,
    required this.createdAt,
    required this.user,
  });

  factory AppNotification.fromJson(Map<String, dynamic> json) {
    return AppNotification(
      id: json['id'],
      message: json['message'],
      title: json['title'],
      isRead: json['is_read'],
      createdAt: DateTime.parse(json['created_at']),
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'message': message,
      'title': title,
      'is_read': isRead,
      'created_at': createdAt.toIso8601String(),
      'user': user,
    };
  }
}
