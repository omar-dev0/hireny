import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../org_profile/domain/models/reviews.dart';
import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/org_post.dart';
import '../../domain/repo_contract/seeker_repository.dart';
import '../data_source/seeker_data_source.dart';

@Injectable(as: SeekerRepository)
class SeekerRepoImpl implements SeekerRepository {
  final SeekerDataSource _dataSource;

  @factoryMethod
  SeekerRepoImpl(this._dataSource);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() {
    return _dataSource.getNotRegisteredCourses();
  }

  @override
  Future<Result<List<JobPost>>> getNotAppliedJobPosts() {
    return _dataSource.getNotAppliedJobPosts();
  }

  @override
  Future<Result<num>?> showInsight(Map<String, String> data) {
    return _dataSource.showInsight(data);
  }

  @override
  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId) {
    return _dataSource.getJobPostDetails(jobId);
  }

  @override
  Future<Result<List<OrgPost>>> getAllOrganizations() {
    return _dataSource.getAllOrganizations();
  }

  Future<Result<Course>> getCourseDetails(int courseId) {
    return _dataSource.getCourseDetails(courseId);
  }

  Future<Result<void>?> applyJob(
    num jobId,
    bool haveApplication,
    List<dynamic> answers,
  ) {
    return _dataSource.applyJob(jobId, haveApplication, answers);
  }

  @override
  Future<Result<ReviewModel>?> createReview(String review, num id) {
    return _dataSource.createReview(review, id);
  }

  @override
  Future<Result<void>?> deleteReview(num id) {
    return _dataSource.deleteReview(id);
  }

  @override
  Future<Result<void>?> updateReview(String review, num id) {
    return _dataSource.updateReview(review, id);
  }

  @override
  Future<Result<List<ReviewModel>>?> getReviews(num id) {
    return _dataSource.getReviews(id);
  }

  @override
  Future<Result<List<JobPost>>> getThreeBestJobs() {
    return _dataSource.getThreeBestJobs();
  }

  @override
  Future<Result<List<JobPost>>> getRelatedJobs(int id) {
    return _dataSource.getRelatedJobs(id);
  }
}
