import '../../../../result.dart';
import '../../domain/notification_module.dart';

abstract class NotificationDataSource{
  Future<Result<List<AppNotification>>?> getNotification();
}