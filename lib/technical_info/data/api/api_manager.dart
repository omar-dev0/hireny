import 'package:dio/dio.dart';
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/api/url_constants.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import '../models/response/education_model.dart';

@singleton
@injectable

class TechApiManager {
  final Dio _dio;
  String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxMDcwODYwLCJpYXQiOjE3NTEwMjc2NjAsImp0aSI6Ijg5MDk5MWJkYmIwZjQyNmY4ZThmMmU5MGVmZTFkZDg4IiwidXNlcl9pZCI6MjksImlkIjoyOSwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3QxMjNAZ21haWwuY29tIiwicm9sZSI6InNlZWtlciIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyJ9.-7DaZkJKmp2MROE02jQxbYYg1vwViTHP_JJDo2PchGA";TechApiManager(this._dio);
  List<String> deleteApi = [
    "",
    UrlConstants.deleteCourse,
    UrlConstants.deleteCertificate,
    UrlConstants.deleteEdu,
    UrlConstants.deleteExperience,
  ];
  List<String> addApi = [
    "",
    UrlConstants.addCourse,
    UrlConstants.addCertificate,
    UrlConstants.addEdu,
    UrlConstants.addExperience,
  ];
  List<String> updateApi = [
    "",
    UrlConstants.updateCourse,
    UrlConstants.updateCertificate,
    UrlConstants.updateEdu,
    UrlConstants.updateExperience,
  ];



 /// get
  Future<Result<TechInfoResponse>> getTechInfo(String token) async {
    try {
      final response = await _dio.get(
        UrlConstants.getTechInfo,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;
        if (data != null) {
          final techInfo = TechInfoResponse.fromJson(data);
          return Success(response: techInfo);
        } else {
          return Error(error: "Invalid data format received from server.");
        }
      } else {
        return Error(error: "Failed to load tech info: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Exception occurred: ${e.toString()}");
    }
  }
  /// Add
  Future<Result<void>> addTechInfo(dynamic obj , int addID) async {
    try {
      print(obj);
      final response = await _dio.post(
        addApi[addID],
        data: obj.toJson(),
        options: Options(headers: {'Authorization': 'Bearer $token','Content-Type': 'application/json'},),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        return Success();
      } else {
        return Error();
      }
    } catch (e) {
      return Error();
    }
  }
  /// Delete
  Future<Result<void>> deleteTechInfo(String id,int deleteID) async {
    try {
      final response = await _dio.delete(
        "${deleteApi[deleteID]}/$id/",
        options: Options(headers: {'Authorization': ' Bearer $token'}));

      if (response.statusCode == 200 || response.statusCode == 204) {
        // print("Certificate deleted successfully");
        return Success();
      } else {
        return Error(error: "Failed to delete certificate: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error deleting certificate: $e");
    }
  }
  /// update
  Future<Result<void>> updateTechInfo(String id,dynamic data,int updateID) async {
    try {
      final response = await _dio.put(
          "${updateApi[updateID]}/$id/",
          data: data.toJson(),
          options: Options(headers: {'Authorization': 'Bearer $token','Content-Type': 'application/json'},),
      );
      if (response.statusCode == 200 || response.statusCode == 204) {
        return Success();
      } else {
        return Error(error: "Failed to update: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error update : $e");
    }
  }

}
