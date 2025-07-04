import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hireny/features/services/data/service_api/service_api_const.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../../../../result.dart';
import '../../domain/models/request/service_post_request.dart';


@singleton
@injectable
class ServiceApiManager {
  final Dio _dio;

  ServiceApiManager(this._dio);
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxNjIzNjcwLCJpYXQiOjE3NTE1ODA0NzAsImp0aSI6ImIzM2VkNjU4MTZkODRiMGQ4ODMzMzBjZTgyM2FlOTEyIiwidXNlcl9pZCI6MzEsImlkIjozMSwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3RAY29tYW55LmNvbSIsInJvbGUiOiJvcmdBZG1pbiIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyIsIm9yZ2FuaXphdGlvbiI6OH0.meRlLrgojcbv5CQQUJ6y67WU78bgGamr0ZwvOaoSp1c";
  ///  add service post
  Future<Result<ServiceResponse>> addServicePost(ServiceRequestModel service) async {
    try {
      final response = await _dio.post(
        ServiceApiConst.addServicePost,
        data: service.toJson(), options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type' : 'application/json'
            },
      )
      );


      if (response.statusCode == 200 || response.statusCode == 201) {
        final serviceResponse = ServiceResponse.fromJson(response.data);

        // Add to the static list
        AppSharedData.servicesOrg.add(serviceResponse);

        return Success(response: serviceResponse);
      } else {
        return Error(error:"Failed to add service. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error:"Error occurred: $e");
    }
  }

  /// get services
  Future<Result<void>> getServices(int id) async {
    debugPrint("call api");
    try {
      final response = await _dio.get(
        "${ServiceApiConst.getServices}8",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        List<ServiceResponse> serviceResponse = (response.data as List)
            .map((json) => ServiceResponse.fromJson(json))
            .toList();

        AppSharedData.servicesOrg.addAll(serviceResponse);
       debugPrint(response.data);
        return Success(response: serviceResponse);
      } else {
        return Error(error: "Failed to get services. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error occurred: $e");
    }
  }


}

