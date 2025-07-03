import 'package:injectable/injectable.dart';

import '../../domain/entities/course_entity.dart';
import '../../domain/repositories/CourseRepo.dart';
import '../data_sources/course_data_interface.dart';

@Injectable(as: CourseRepo)
class CourseRepoImpl implements CourseRepo {
  final CourseDataInterface dataSource;

  CourseRepoImpl(this.dataSource);

  @override
  Future<CourseEntity> deleteCourse(CourseEntity courseData) async {
    return await dataSource.deleteCourse(courseData);
  }

  @override
  Future<List<CourseEntity>> showCourses() async {
    return await dataSource.showCourses();
  }
}
