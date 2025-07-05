import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/view_application/data/api/application_api_const.dart';
import 'package:hireny/features/view_application/domain/model/user_application.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

@singleton
@injectable
class ApplicationApi {
  Dio _dio;
  ApplicationApi(this._dio);

  Future<Result<List<SeekerApplication>>?> getUserApplication() async {
    try {
      final response = await _dio.get(
        MyApplicationApiConst.getUserApplicationv,
      );
      if (response.statusCode == 200) {
        List<SeekerApplication> applications = [];
        for (var element in response.data) {
          applications.add(SeekerApplication.fromJson(element));
        }
        return Success(response: applications);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
        return Error(error: e.toString());
      }
    }
    return null;
  }
}
