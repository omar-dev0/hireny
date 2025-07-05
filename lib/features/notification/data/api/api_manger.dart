import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/notification/domain/notification_module.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import 'api_const.dart';

@singleton
@injectable
class NotificationApiManger {
  final Dio dio;
  @factoryMethod
  NotificationApiManger(this.dio);
  Future<Result<List<AppNotification>>?> getNotification() async {
    try {
      final response = await dio.get(NotificationApiConst.getNotification);
      if (response.statusCode == 200) {
        final data = response.data['notifications'] as List;
        final notifications =
            data.map((e) => AppNotification.fromJson(e)).toList();
        return Success(response: notifications);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Error(error: e.toString());
    } catch (e) {
      if (kDebugMode) {
        print(e);
      }
      return Error(error: e.toString());
    }
    return null;
  }
}
