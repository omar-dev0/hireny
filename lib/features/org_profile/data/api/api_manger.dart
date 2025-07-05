import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../seeker/domain/modules/job_details.dart';
import 'const_apis.dart';

@singleton
@injectable
class OrgProfileApi {
  final Dio dio;
  OrgProfileApi(this.dio);

  Future<Result<List<ReviewModel>>?> getOrgReviews(num id) async {
    try {
      final response = await dio.get(
        '${OrgProfileApiConst.getOrgReviews}$id/reviews',
      );
      if (response.statusCode == 200) {
        final List<ReviewModel> reviews = [];
        for (var review in response.data) {
          reviews.add(ReviewModel.fromJson(review));
        }
        return Success(response: reviews);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.toString());
    }
    return null;
  }

  Future<Result<ReviewModel>?> createReview(String review, num id) async {
    try {
      final response = await dio.post(
        '${OrgProfileApiConst.creatReview}$id/reviews/create/',
        data: {'message': review},
        options: Options(headers: {'Content-Type': 'application/json'}),
      );
      if (response.statusCode == 299) {
        return Error(error: '299');
      } else if (response.statusCode == 201) {
        return Success(response: ReviewModel.fromJson(response.data));
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.toString());
    }
    return null;
  }

  Future<Result<void>?> deleteReview(num id) async {
    try {
      await dio.delete(
        '${OrgProfileApiConst.deleteOrgReview}reviews/$id/delete/',
      );
      return Success();
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<Result<void>?> updateReview(String review, num id) async {
    try {
      var response = await dio.put(
        '${OrgProfileApiConst.updateOrgReview}reviews/$id/update/',
        data: FormData.fromMap({"message": review})
      );
      if (response.statusCode == 299) {
        return Error(error: '299');
      }
      return Success();
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return Error(error: '299');
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
    }
    return null;
  }

  Future<Result<List<JobDetailsModel>>?> getOrgJobs(num id) async {
    try {
      final response = await dio.get('${OrgProfileApiConst.getOrgJobs}$id');
      if (response.statusCode == 200) {
        final List<JobDetailsModel> jobs = [];
        for (var job in response.data) {
          jobs.add(JobDetailsModel.fromJson(job));
        }
        return Success(response: jobs);
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print(e.message);
      }
      return Error(error: e.message);
    } catch (e) {
      if (kDebugMode) {
        print(e.toString());
      }
      return Error(error: e.toString());
    }
    return null;
  }
}
