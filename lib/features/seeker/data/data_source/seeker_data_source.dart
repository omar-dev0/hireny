import 'package:hireny/result.dart';

import '../../domain/modules/course.dart';
import '../../domain/modules/job_post.dart';

abstract class SeekerDataSource {
  Future<Result<List<Course>>> getNotRegisteredCourses();
  Future<Result<List<JobPost>>> getNotAppliedJobPosts();
  Future<Result<num>?> showInsight(Map<String, String> data);
}