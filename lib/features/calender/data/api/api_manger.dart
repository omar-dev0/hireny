import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/event.dart';
import 'api_const.dart';

@singleton
@injectable
class CalenderApi {
  final Dio _dio;
  @factoryMethod
  CalenderApi(this._dio);

  Future<Result<void>?> addEvent(EventModel event) async {
    try {
      final FormData data = FormData.fromMap(event.toJson());
      var result = await _dio.post(CalenderApiConst.addEvent, data: data);
      if (result.statusCode == 201) {
        return Success();
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error();
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error();
    }
    return null;
  }

  Future<Result<List<EventModel>>?> getUserEvents() async {
    try {
      var result = await _dio.get(CalenderApiConst.getUserEvents);
      if (result.statusCode == 200) {
        List<EventModel> events = [];
        for (var event in result.data) {
          events.add(EventModel.fromJson(event));
        }
        return Success(response: events);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }
}
