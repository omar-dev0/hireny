import 'package:hireny/features/org_profile/domain/models/reviews.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/api/api_manger.dart';
import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/job_post.dart';
import '../../domain/modules/org_post.dart';
import '../api/seeker_api.dart';
import '../data_source/seeker_data_source.dart';

@Injectable(as: SeekerDataSource)
class SeekerDataSourceImpl implements SeekerDataSource {
  final SeekerApi seekerApi;

  @factoryMethod
  SeekerDataSourceImpl(this.seekerApi);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() async {
    return seekerApi.getNotRegisteredCourses();
  }

  @override
  Future<Result<List<JobPost>>> getNotAppliedJobPosts() async {
    return seekerApi.getNotAppliedJobPosts();
  }

  @override
  Future<Result<num>?> showInsight(Map<String, String> data) {
    return seekerApi.showInsight(data);
  }

  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId) {
    return seekerApi.getJobPostDetails(jobId);
  }

  Future<Result<List<OrgPost>>> getAllOrganizations() {
    return seekerApi.getAllOrganizations();
  }

  Future<Result<Course>> getCourseDetails(int courseId) {
    return seekerApi.getCourseDetails(courseId);
  }
  Future<Result<void>?> applyJob(
    num jobId,
    bool haveApplication,
    List<dynamic> answers,
  ) {
    return seekerApi.applyJob(jobId, haveApplication, answers);
  }

  @override
  Future<Result<ReviewModel>?> createReview(String review, num id) {
    return seekerApi.createReview(review, id);
  }

  @override
  Future<Result<void>?> deleteReview(num id) {
    return seekerApi.deleteReview(id);
  }

  @override
  Future<Result<void>?> updateReview(String review, num id) {
    return seekerApi.updateReview(review, id);
  }

  @override
  Future<Result<List<ReviewModel>>?> getReviews(num id) {
    return seekerApi.getReviews(id);
  }



}
