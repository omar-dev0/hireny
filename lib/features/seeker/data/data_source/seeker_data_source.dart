import 'package:hireny/result.dart';

import '../../../org_profile/domain/models/reviews.dart';
import '../../domain/modules/course.dart';
import '../../domain/modules/job_details.dart';
import '../../domain/modules/job_post.dart';
import '../../domain/modules/org_post.dart';

abstract class SeekerDataSource {
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


}
