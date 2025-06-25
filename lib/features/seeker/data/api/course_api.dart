import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';

import '../../../../result.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/exceptions/dio_exception.dart';
import '../../domain/modules/course.dart';
import 'course_consts.dart';

@singleton
@injectable
class CourseApi {
  final Dio _dio;

  CourseApi(this._dio);
  Future<Result<List<Course>>> getNotRegisteredCourses() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
            'Bearer ${AppSharedData.user?.accessToken}',
      };
      final response = await _dio.get(CourseConst.getNotRegisteredCourses);

      if (response.statusCode == 200 && response.data != null) {
        final List<Course> courses =
            (response.data as List)
                .map((item) => Course.fromJson(item))
                .toList();

        return Success(response: courses);
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
