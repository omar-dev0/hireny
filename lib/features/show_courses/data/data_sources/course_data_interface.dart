import 'package:hireny/features/show_courses/data/models/course_reponse.dart';
import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';

abstract class CourseDataInterface {
  Future<List<CourseResponse>> showCourses();
  Future<CourseResponse> deleteCourse(CourseEntity courseData);
}
