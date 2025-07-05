import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:hireny/features/services/data/service_api/service_api_const.dart';
import 'package:hireny/features/services/domain/models/response/service_post_response.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../../domain/models/request/service_post_request.dart';


@singleton
@injectable
class ServiceApiManager {
  final Dio _dio;

  ServiceApiManager(this._dio);
  String token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxNzMyODA3LCJpYXQiOjE3NTE2ODk2MDcsImp0aSI6ImQwMjNiZDg3Mzc0YjQyMTBhMDEwNjk1ZDViNzY3YWIzIiwidXNlcl9pZCI6MzIsImlkIjozMiwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3RAY29tcGFueS5jb20iLCJyb2xlIjoib3JnQWRtaW4iLCJwaG90byI6Ii9tZWRpYS9waG90b3MvZGVmYXVsdC5wbmciLCJvcmdhbml6YXRpb24iOjl9.0pGKGfhKE4RG_eXVPBnbM_J80_edN6O-LeUR8CTl7Lo";
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
    try {
      final response = await _dio.get(
        "${ServiceApiConst.getServices}9",
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

  /// delete service
  Future<Result<void>> deleteService(int id) async {
    try {
      final response = await _dio.delete(
        "${ServiceApiConst.deleteServicePost}$id/",
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        // 🔹 Remove from local list
        AppSharedData.servicesOrg.removeWhere((service) => service.id == id);

        debugPrint("Service deleted successfully: ${response.data}");
        return Success();
      } else {
        return Error(error: "Failed to delete service. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error occurred: $e");
    }
  }

  /// update service
  Future<Result<void>> updateService(int id, ServiceRequestModel service) async {

    final url = "${ServiceApiConst.updateServicePost}$id/";
    try {
      final response = await _dio.put(
        url,
        data: service.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // debugPrint("Response status: ${response.statusCode}");
      // debugPrint("Response data: ${response.data}");

      // Success case
      if (response.statusCode == 200 || response.statusCode == 201) {
        final index = AppSharedData.servicesOrg.indexWhere((s) => s.id == id);
        if (index != -1) {
          // AppSharedData.servicesOrg[index] = ;
        }
        debugPrint("✅ Service updated successfully");
        return Success();
      } else {
        debugPrint("❌ Failed to update service. Status: ${response.statusCode}");
        return Error(error: "Failed to update service. Status code: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      debugPrint("❌ Exception occurred: $e");
      debugPrint("🔍 StackTrace: $stackTrace");
      return Error(error: "Error occurred: $e");
    }
  }



}

