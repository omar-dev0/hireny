import 'package:hireny/result.dart';
import '../modules/course.dart';

abstract class CourseRepository {
  Future<Result<List<Course>>> getNotRegisteredCourses();
}