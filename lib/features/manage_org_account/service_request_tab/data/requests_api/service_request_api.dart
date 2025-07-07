import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/data/requests_api/service_request_api_const.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../models/service_applications.dart';

@singleton
@injectable
class ServiceRequestApi {
  final Dio _dio;

  @factoryMethod
  ServiceRequestApi(this._dio);

  Future<Result<void>> getServiceApplications() async {
    if (AppSharedData.serviceApplications.isNotEmpty) {
      return Success(response: null);
    }

    try {
      final response = await _dio.get(
        ServiceRequestApiConst.getServiceApplications,
        options: Options(headers: {
          'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxOTM4MjM3LCJpYXQiOjE3NTE4OTUwMzcsImp0aSI6IjdiMGUyNzkxNGE5YzQxMTJiMzk5OGM0NTM1NmQwZGFiIiwidXNlcl9pZCI6MzgsImlkIjozOCwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3RAY29tcGFueS5jb20iLCJyb2xlIjoib3JnQWRtaW4iLCJwaG90byI6Ii9tZWRpYS9waG90b3MvZGVmYXVsdC5wbmciLCJvcmdhbml6YXRpb24iOjEwfQ.YvrpnEyNsdMW3aAHXFzySUyzggDGtd9OXBdbvOCWAxM',
          'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 200) {
        AppSharedData.serviceApplications = (response.data as List)
            .map((item) => Application.fromJson(item))
            .toList();
        return Success(response: null);
      } else {
        return Error(error: 'Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Error(error: e.message ?? 'Dio error');
    } catch (e) {
      return Error(error: e.toString());
    }
  }
  // ✅ DELETE: Delete service application by ID
  Future<Result<void>> deleteServiceApplication(int id) async {
    try {
      final response = await _dio.delete(
        '${ServiceRequestApiConst.deleteServiceApplication}/$id/delete/',
        options: Options(
            headers: {
              'Authorization': 'Bearer eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxOTM4MjM3LCJpYXQiOjE3NTE4OTUwMzcsImp0aSI6IjdiMGUyNzkxNGE5YzQxMTJiMzk5OGM0NTM1NmQwZGFiIiwidXNlcl9pZCI6MzgsImlkIjozOCwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3RAY29tcGFueS5jb20iLCJyb2xlIjoib3JnQWRtaW4iLCJwaG90byI6Ii9tZWRpYS9waG90b3MvZGVmYXVsdC5wbmciLCJvcmdhbml6YXRpb24iOjEwfQ.YvrpnEyNsdMW3aAHXFzySUyzggDGtd9OXBdbvOCWAxM',

              'Content-Type': 'application/json',
        }),
      );

      if (response.statusCode == 204 || response.statusCode == 200) {
        // Optionally remove locally if needed:
        AppSharedData.serviceApplications.removeWhere((app) => app.id == id);
        return Success(response: null);
      } else {
        return Error(error: 'Unexpected status code: ${response.statusCode}');
      }
    } on DioException catch (e) {
      return Error(error: e.message ?? 'Dio error');
    } catch (e) {
      return Error(error: e.toString());
    }
  }


}
