import 'package:dio/dio.dart';
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
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxNDUxMTMxLCJpYXQiOjE3NTE0MDc5MzEsImp0aSI6IjAxZjFhM2RlYTM5NjRkYjliNjJmMDY4Y2NiZWVkNDBlIiwidXNlcl9pZCI6MzEsImlkIjozMSwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3RAY29tYW55LmNvbSIsInJvbGUiOiJvcmdBZG1pbiIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyIsIm9yZ2FuaXphdGlvbiI6OH0.RIQKhDrLMEyGg8wVw5RhJwPLW70yMsSSVulKRN_lnaM";
  //  add service post
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



}

