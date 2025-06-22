import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';
import 'package:hireny/features/show_courses/domain/repositories/CourseRepo.dart';
import 'package:injectable/injectable.dart';
@injectable
class DeleteCourse{
  CourseRepo courseRepo;

  DeleteCourse({required this.courseRepo});
  Future<CourseEntity> call(CourseEntity courseData) async {
    return await courseRepo.deleteCourse(courseData);
  }
}