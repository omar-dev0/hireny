import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';
import 'package:hireny/features/show_courses/domain/repositories/CourseRepo.dart';
import 'package:injectable/injectable.dart';

@injectable
class ShowCourses {
  CourseRepo courseRepo;

  ShowCourses({required this.courseRepo});
  Future<List<CourseEntity>> call() async {
    return await courseRepo.showCourses();
  }
}
