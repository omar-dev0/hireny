import 'package:hireny/features/show_courses/data/api/course_api_manager.dart';
import 'package:hireny/features/show_courses/data/models/seeker_courses_registered.dart';
import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';
import 'package:injectable/injectable.dart';
import 'course_data_interface.dart';

@LazySingleton(as: CourseDataInterface)
class LocalCourseData implements CourseDataInterface {

 CoursesApiManager coursesApiManager;


 LocalCourseData(this.coursesApiManager);

 @override
  Future<void> showCourses(){
    return coursesApiManager.getSeekerRegisteredCourses();
  }

}
