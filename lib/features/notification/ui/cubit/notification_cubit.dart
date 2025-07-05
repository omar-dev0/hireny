import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/notification/domain/notification_module.dart';
import 'package:hireny/features/notification/domain/repo_contract/notification_repo.dart';
import 'package:hireny/features/notification/ui/cubit/state/notifciation_state.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

@injectable
class NotificationCubit extends Cubit<NotificationState> {
  NotificationRepo notificationRepo;
  @factoryMethod
  NotificationCubit(this.notificationRepo) : super(InitNotification());

  Future<void> getNotification() async {
    try {
      emit(NotificationLoading());
      final result = await notificationRepo.getNotification();
      switch (result) {
        case null:
          {
            emit(ErrorNotificationGet());
          }
        case Success<List<AppNotification>>():
          {
            AppSharedData.notifications = result.response ?? [];
            emit(SuccessNotificationGet(notifications: result.response ?? []));
          }
        case Error<List<AppNotification>>():
          {
            emit(ErrorNotificationGet());
          }
      }
    } catch (e) {
      emit(ErrorNotificationGet());
    }
  }
}
