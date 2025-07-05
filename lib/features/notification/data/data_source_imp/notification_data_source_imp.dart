import 'package:hireny/features/notification/data/api/api_manger.dart';
import 'package:hireny/features/notification/data/data_source/notification_data_source.dart';
import 'package:hireny/features/notification/domain/notification_module.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: NotificationDataSource)
class NotificationDataSourceImp extends NotificationDataSource{
  NotificationApiManger notificationApiManger;
  @factoryMethod
  NotificationDataSourceImp(this.notificationApiManger);
  @override
  Future<Result<List<AppNotification>>?> getNotification() {
    return notificationApiManger.getNotification();

  }

}