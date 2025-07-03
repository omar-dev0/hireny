import 'dart:io';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/seeker/domain/modules/org_post.dart';
import 'package:injectable/injectable.dart';
import '../../../../result.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/exceptions/dio_exception.dart';
import '../../../auth/domain/modules/seeker/seeker.dart';
import '../../domain/modules/organization.dart';
import '../../domain/modules/seeker.dart';
import '../../domain/modules/service.dart';
import 'org_consts.dart';

@singleton
@injectable
class OrgApi {
  final Dio _dio;

  OrgApi(this._dio);
  Future<Result<List<SeekerModel>>> getAllSeekers() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
        'Bearer ${AppSharedData.user?.accessToken}',
      };
      final response = await _dio.get(OrgConst.getAllSeekers);

      if (response.statusCode == 200 && response.data != null) {
        final List<SeekerModel> seekers =
        (response.data as List)
            .map((item) => SeekerModel.fromJson(item))
            .toList();

        return Success(response: seekers);
      } else {
        return Error(error: 'Failed to load courses');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getNotRegisteredCourses: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getNotRegisteredCourses: $e');
      }
      return Error(error: e.toString());
    }
  }
  Future<Result<List<ServiceModel>>> getNotAppliedServicePosts() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
        'Bearer ${AppSharedData.user?.accessToken}',
      };
      final response = await _dio.get(OrgConst.getNotAppliedServicePosts);

      if (response.statusCode == 200 && response.data != null) {
        final List<ServiceModel> services =
        (response.data as List)
            .map((item) => ServiceModel.fromJson(item))
            .toList();

        return Success(response: services);
      } else {
        return Error(error: 'Failed to load courses');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getNotRegisteredCourses: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getNotRegisteredCourses: $e');
      }
      return Error(error: e.toString());
    }
  }
  Future<Result<List<OrgPostOrg>>> getAllOrganizations() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
        'Bearer ${AppSharedData.user?.accessToken}',
      };
      final response = await _dio.get(OrgConst.getAllOrganizations);

      if (response.statusCode == 200 && response.data != null) {
        final List<OrgPostOrg> orgs =
        (response.data as List)
            .map((item) => OrgPostOrg.fromJson(item))
            .toList();

        return Success(response: orgs);
      } else {
        return Error(error: 'Failed to load courses');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getNotRegisteredCourses: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getNotRegisteredCourses: $e');
      }
      return Error(error: e.toString());
    }
  }


}
