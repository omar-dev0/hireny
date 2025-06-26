import 'package:hireny/features/seeker/domain/modules/job_post.dart';
import 'package:hireny/result.dart';
import '../modules/course.dart';

abstract class SeekerRepository {
  Future<Result<List<Course>>> getNotRegisteredCourses();
  Future<Result<List<JobPost>>> getNotAppliedJobPosts();
  Future<Result<num>?> showInsight(Map<String, String> data);
}