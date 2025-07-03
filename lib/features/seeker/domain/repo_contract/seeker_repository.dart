import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
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
}
