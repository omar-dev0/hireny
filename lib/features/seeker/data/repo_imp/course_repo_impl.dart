
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/course.dart';
import '../../domain/repo_contract/course_repository.dart';
import '../data_source/course_data_source.dart';

@Injectable(as: CourseRepository)
class CourseRepoImpl implements CourseRepository {
  final CourseDataSource _dataSource;

  @factoryMethod
  CourseRepoImpl(this._dataSource);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() {
    return _dataSource.getNotRegisteredCourses();
  }
}