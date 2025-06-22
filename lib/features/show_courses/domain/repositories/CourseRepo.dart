import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';

abstract class CourseRepo{

  Future<CourseEntity>deleteCourse(CourseEntity courseData);
  Future<List<CourseEntity>>showCourses();



}