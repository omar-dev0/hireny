import 'package:injectable/injectable.dart';

import '../../../../result.dart';
import '../../domain/notification_module.dart';
import '../../domain/repo_contract/notification_repo.dart';
import '../data_source/notification_data_source.dart';

@Injectable(as: NotificationRepo)
class NotificationRepoImp implements NotificationRepo {
  @factoryMethod
  NotificationRepoImp(this.notificationDataSource);
  final NotificationDataSource notificationDataSource;
  @override
  Future<Result<List<AppNotification>>?> getNotification() {
    return notificationDataSource.getNotification();
  }
}
