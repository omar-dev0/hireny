import '../../../../result.dart';
import '../notification_module.dart';

abstract class NotificationRepo {
  Future<Result<List<AppNotification>>?> getNotification();
}