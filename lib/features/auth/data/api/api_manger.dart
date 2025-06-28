import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/auth/domain/modules/org/org_admin.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/features/auth/domain/modules/user/user.dart';
import 'package:hireny/result.dart';
import 'package:hireny/utils/dio_provider.dart';
import 'package:injectable/injectable.dart';

import '../../../../utils/exceptions/dio_exception.dart';
import 'api_const.dart';

@singleton
@injectable
class ApiManger {
  final Dio _dio;

  ApiManger(this._dio);

  Future<Result<Seeker?>?> regSeeker(Seeker seeker,
      String password,
      File? cv,) async {
    try {
      final formMap = seeker.toJson()
        ..addAll({'password': password});
      final formData = FormData.fromMap({
        if (cv != null) 'cv': await MultipartFile.fromFile(cv.path),
        ...formMap,
      });

      final response = await _dio.post(ApiConst.reg, data: formData);

      if (response.data == null) return null;

      return Success(response: Seeker.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions
          .fromDioError(e)
          .message;
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

  Future<Result<OrgAdmin?>?> regOrg(OrgAdmin orgAdmin,
      String password,
      File? orgProf,) async {
    try {
      final formMap = orgAdmin.toJson()
        ..addAll({'password': password});
      final formData = FormData.fromMap({
        if (orgProf != null)
          'orgProf': await MultipartFile.fromFile(orgProf.path),
        ...formMap,
      });

      final response = await _dio.post(ApiConst.reg, data: formData);

      if (response.data == null) return null;

      return Success(response: OrgAdmin.fromJson(response.data));
    } on DioException catch (e) {
      final errorMessage = DioExceptions
          .fromDioError(e)
          .message;
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

  Future<Result<Map<String, dynamic>>?> login(String email,
      String password,) async {
    FormData formData = FormData.fromMap({
      'email': email,
      'password': password,
    });
    try {
      final response = await _dio.post(ApiConst.login, data: formData);
      return Success(response: response.data as Map<String, dynamic>);
    } on DioException catch (e) {
      final errorMessage = DioExceptions
          .fromDioError(e)
          .message;
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

/////////////////////// change password
  Future<Result<void>> changePassword(String token, String oldPassword, String newPassword,) async {
    try {
      final response = await _dio.post(
        ApiConst.changePass,
        data: {
          'old_password': oldPassword,
          'new_password': newPassword,
        },
        options: Options(headers: {
          HttpHeaders.authorizationHeader: 'Bearer $token',
          HttpHeaders.contentTypeHeader: 'application/json',
        }),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Success(response: null);
      } else {
        return Error(
            error: "Failed to change password. Status: ${response.statusCode}");
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions
          .fromDioError(e)
          .message;
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
}

