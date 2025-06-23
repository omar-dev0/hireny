import 'package:hireny/result.dart';

import '../../domain/modules/course.dart';

abstract class CourseDataSource {
  Future<Result<List<Course>>> getNotRegisteredCourses();
}