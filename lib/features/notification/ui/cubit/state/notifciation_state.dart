import '../../../domain/notification_module.dart';

abstract class NotificationState {}

class InitNotification extends NotificationState {}

class NotificationLoading extends NotificationState {}

class SuccessNotificationGet extends NotificationState {
  final List<AppNotification> notifications;
  SuccessNotificationGet({required this.notifications});
}

class ErrorNotificationGet extends NotificationState {}
