import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
import '../../../org_profile/domain/models/reviews.dart';
import '../modules/course.dart';
import '../modules/job_details.dart';
import '../modules/org_post.dart';

abstract class SeekerRepository {
  Future<Result<List<Course>>> getNotRegisteredCourses();
  Future<Result<List<JobPost>>> getNotAppliedJobPosts();
  Future<Result<num>?> showInsight(Map<String, String> data);
  Future<Result<JobDetailsModel>> getJobPostDetails(int jobId);
  Future<Result<List<OrgPost>>> getAllOrganizations();
  Future<Result<Course>> getCourseDetails(int courseId);

  Future<Result<void>?> applyJob(
    num jobId,
    bool haveApplication,
    List<dynamic> answers,
  );
  Future<Result<ReviewModel>?> createReview(String review, num id);
  Future<Result<void>?> deleteReview(num id);
  Future<Result<void>?> updateReview(String review, num id);
  Future<Result<List<ReviewModel>>?> getReviews(num id);
  Future<Result<List<JobPost>>> getThreeBestJobs();
  Future<Result<List<JobPost>>> getRelatedJobs(int id);
}
