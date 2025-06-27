import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/seeker/domain/modules/org_post.dart';
import 'package:injectable/injectable.dart';

import '../../../../result.dart';
import '../../../../utils/data_shared/app_shared_data.dart';
import '../../../../utils/exceptions/dio_exception.dart';
import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/job_post.dart';
import 'seeker_consts.dart';

@singleton
@injectable
class SeekerApi {
  final Dio _dio;

  SeekerApi(this._dio);
  Future<Result<List<Course>>> getNotRegisteredCourses() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
            'Bearer ${AppSharedData.user?.accessToken}',
      };
      final response = await _dio.get(SeekerConst.getNotRegisteredCourses);

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
  Future<Result<List<JobPost>>> getNotAppliedJobPosts() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
            'Bearer ${AppSharedData.user?.accessToken}',
      };

      final response = await _dio.get(SeekerConst.getNotAppliedJobPosts);

      if (response.statusCode == 200 && response.data != null) {
        final List<JobPost> jobPosts =
            (response.data as List)
                .map((item) => JobPost.fromJson(item))
                .toList();

        return Success(response: jobPosts);
      } else {
        return Error(error: 'Failed to load job posts');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getNotAppliedJobPosts: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getNotAppliedJobPosts: $e');
      }
      return Error(error: e.toString());
    }
  }
  Future<Result<num>?> showInsight(Map<String, String> data) async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader:
            'Bearer ${AppSharedData.user?.accessToken}',
      };
      FormData formData = FormData.fromMap(data);
      var response = await _dio.post(
        SeekerConst.salaryInsightes,
        data: formData,
      );
      if (response.statusCode == 200) {
        return Success(
          response: response.data['predicted_salary_usd_per_month'],
        );
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in showInsight: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in showInsight: $e');
      }
      return Error(error: e.toString());
    }
    return null;
  }
  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId) async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ${AppSharedData.user?.accessToken}',
      };

      final response = await _dio.get('${SeekerConst.getJobPostDetails}$jobId');

      if (response.statusCode == 200 && response.data != null) {
        final jobDetails = JobDetailsModel.fromJson(response.data);

        return Success(response: jobDetails);
      } else {
        return Error(error: 'Failed to load job details');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getJobPostDetails: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getJobPostDetails: $e');
      }
      return Error(error: e.toString());
    }
  }
  Future<Result<List<OrgPost>>> getAllOrganizations() async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ${AppSharedData.user?.accessToken}',
      };

      final response = await _dio.get(SeekerConst.getAllOrganizations);

      if (response.statusCode == 200 && response.data != null) {
        final List<OrgPost> organizations = (response.data as List)
            .map((item) => OrgPost.fromJson(item))
            .toList();

        return Success(response: organizations);
      } else {
        return Error(error: 'Failed to load organizations');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getAllOrganizations: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getAllOrganizations: $e');
      }
      return Error(error: e.toString());
    }
  }
  Future<Result<Course>> getCourseDetails(int courseId) async {
    try {
      _dio.options.headers = {
        HttpHeaders.contentTypeHeader: 'multipart/form-data',
        HttpHeaders.authorizationHeader: 'Bearer ${AppSharedData.user?.accessToken}',
      };

      final response = await _dio.get('${SeekerConst.getCourseDetails}$courseId');

      if (response.statusCode == 200 && response.data != null) {
        final course = Course.fromJson(response.data);
        return Success(response: course);
      } else {
        return Error(error: 'Failed to load course details');
      }
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).message;
      if (kDebugMode) {
        print('DioException in getCourseDetails: $e');
      }
      return Error(error: errorMessage);
    } catch (e) {
      if (kDebugMode) {
        print('General error in getCourseDetails: $e');
      }
      return Error(error: e.toString());
    }
  }
}
