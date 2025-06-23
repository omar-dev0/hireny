import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../auth/data/api/api_manger.dart';
import '../../domain/modules/course.dart';
import '../api/course_api.dart';
import '../data_source/course_data_source.dart';



@Injectable(as: CourseDataSource)
class CourseDataSourceImpl implements CourseDataSource {
  final CourseApi courseApi;

  @factoryMethod
  CourseDataSourceImpl(this.courseApi);

  @override
  Future<Result<List<Course>>> getNotRegisteredCourses() async {
    return courseApi.getNotRegisteredCourses();
  }
}