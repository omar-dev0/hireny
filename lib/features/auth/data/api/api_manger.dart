import 'dart:convert';
import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/assessment/presentation/ui/assessment.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:hireny/utils/dio_provider.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/exceptions/dio_exception.dart';
import '../../domain/modules/assessment/assessment.dart';
import 'api_const.dart';

@singleton
@injectable
class ApiManger {
  final Dio _dio;

  ApiManger(this._dio);

  Future<Result<Seeker?>?> regSeeker(
    Seeker seeker,
    String password,
    File? cv,
  ) async {
    try {
      final formMap = seeker.toJson()..addAll({'password': password});
      final formData = FormData.fromMap({
        if (cv != null) 'cv': await MultipartFile.fromFile(cv.path),
        ...formMap,
      });

      final response = await _dio.post(ApiConst.reg, data: formData);

      if (response.data == null) return null;

      return Success(response: Seeker.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in regSeeker: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in regSeeker: $e');
      }
      return Error(error: e.toString());
    }
  }

  Future<Result<OrgAdmin?>?> regOrg(
    OrgAdmin orgAdmin,
    String password,
    File? orgProf,
  ) async {
    try {
      final formMap = orgAdmin.toJson()..addAll({'password': password});
      final formData = FormData.fromMap({
        if (orgProf != null)
          'orgProf': await MultipartFile.fromFile(orgProf.path),
        ...formMap,
      });

      final response = await _dio.post(ApiConst.reg, data: formData);

      if (response.data == null) return null;

      return Success(response: OrgAdmin.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in regOrg: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in regOrg: $e');
      }
      return Error(error: e.toString());
    }
  }

  Future<Result<Map<String, dynamic>>?> login(
    String email,
    String password,
  ) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    try {
      final response = await _dio.post(ApiConst.login, data: formData);
      return Success(response: response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in login: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in login: $e');
      }
    }
    return null;
  }

  /////////////////////// get user info

  Future<Result<User?>?> getUserInfo(String token) async {
    try {
      final response = await _dio.get(
        ApiConst.getUserInfo,
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );
      if (response.data == null) return null;
      if (response.data['user']['role'] == 'seeker') {
        return Success(response: Seeker.fromJson(response.data));
      } else if (response.data['user']['role'] == 'orgAdmin') {
        return Success(response: OrgAdmin.fromJson(response.data));
      }
    } catch (e) {
      return Error(error: e.toString());
    }
    return null;
  }

  Future<Result<void>?> sendOtp(String email) async {
    try {
      final FormData data = FormData.fromMap({'email': email});
      var response = await _dio.post(ApiConst.verifyEmail, data: data);
      if (response.statusCode == 200) {
        return Success();
      }
    } on DioException catch (e) {
      return Error(error: 'some thing went wrong try latter');
    } catch (e) {
      return Error(error: 'some thing went wrong try latter');
    }
    return null;
  }

  Future<Result<void>?> verifyOtp(String email, String otp) async {
    try {
      final FormData data = FormData.fromMap({'email': email, 'otp': otp});
      var response = await _dio.post(ApiConst.verifyOtp, data: data);
      if (response.statusCode == 200) {
        return Success();
      } else {
        return Error(error: 'some thing went wrong try latter');
      }
    } on DioException catch (e) {
      return Error(error: 'some thing went wrong try latter');
    } catch (e) {
      return Error(error: 'some thing went wrong try latter');
    }
    return null;
  }

  Future<Result<void>?> resetPassword(String email, String newPassword) async {
    try {
      final FormData data = FormData.fromMap({
        'email': email,
        'new_password': newPassword,
      });
      var response = await _dio.post(ApiConst.resetPassword, data: data);
      if (response.statusCode == 200) {
        return Success();
      } else {
        return Error(error: 'some thing went wrong try latter');
      }
    } on DioException catch (e) {
      return Error(error: 'some thing went wrong try latter');
    } catch (e) {
      return Error(error: 'some thing went wrong try latter');
    }
  }

  /////////////////////// update user info
  Future<Result<void>> updateSeekerInfo(String token, Seeker seeker) async {
    try {
      final response = await _dio.put(
        ApiConst.updateUserInfo,
        data: seeker.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200) {
        return Success(response: null);
      } else {
        return Error(error: "Failed to update user info");
      }
    } catch (e) {
      return Error(error: e.toString());
    }
  }

  Future<Result<void>> changePassword(
    String token,
    String oldPassword,
    String newPassword,
  ) async {
    try {
      final response = await _dio.post(
        ApiConst.changePass,
        data: {'old_password': oldPassword, 'new_password': newPassword},
        options: Options(
          headers: {
            HttpHeaders.authorizationHeader: 'Bearer $token',
            HttpHeaders.contentTypeHeader: 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Success(response: null);
      } else {
        return Error(
          error: "Failed to change password. Status: ${response.statusCode}",
        );
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in changePassword: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in changePassword: $e');
      }
      return Error(error: e.toString());
    }
  }

  Future<Result<AssessmentModel?>?> getAssessmentDetailes(int id) async {
    try {
      final response = await _dio.get('${ApiConst.getAssessmentDetail}$id/');
      if (response.data == null) return Error(error: 'some thing went wrong');
      return Success(response: AssessmentModel.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getAssessmentDetailes: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in getAssessmentDetailes: $e');
      }
      return Error(error: 'some thing went wrong');
    }
    return null;
  }

  Future<Result<List<AssessmentModel>?>?> getAssessments() async {
    try {
      final response = await _dio.get(ApiConst.getSeekerAssessments);
      if (response.data == null) return Error(error: 'some thing went wrong');
      if (response.statusCode == 200) {
        if (response.data is List) {
          List<AssessmentModel> assessments = [];
          for (Map<String, dynamic> assessment in response.data) {
            assessments.add(AssessmentModel.fromJson(assessment));
          }
          return Success(response: assessments);
        }
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getAssessments: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in getAssessments: $e');
      }
      return Error(error: 'some thing went wrong');
    }
    return null;
  }

  Future<Result<void>?> submitAssessment(num id, List<dynamic> answers) async {
    try {
      print(answers);
      var resposne = await _dio.put(
        '${ApiConst.submitAssessment}$id/',
        data: {'answers': answers},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (resposne.statusCode == 200) {
        var data = resposne.data;
        int index =
            AppSharedData.assessments?.indexOf(AssessmentModel(id: id)) ?? -1;
        if (index != -1) {
          AppSharedData.assessments![index] = AssessmentModel.fromJson(data);
        }
        return Success();
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in submitAssessment: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in submitAssessment: $e');
      }
      return Error(error: 'some thing went wrong');
    }
  }

  Future<Result<Seeker?>?> extractFromSeekerCV(File cv) async {
    try {
      final formData = FormData.fromMap({
        'cv': await MultipartFile.fromFile(cv.path),
      });
      final response = await _dio.post(
        ApiConst.extractJobSeekerInfoModel,
        data: formData,
      );
      if (response.data == null) {
        return Error(error: 'can\'t extract data from your cv');
      }
      if (response.statusCode != 200) {
        return Error(error: 'can\'t extract data from your cv');
      }
      return Success(response: Seeker.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in extractFromSeekerCV: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General Error in extractFromSeekerCV: $e');
      }
      return Error(error: 'some thing went wrong');
    }
    return null;
  }
}
