import 'package:hireny/features/show_courses/data/models/course_reponse.dart';
import 'package:hireny/features/show_courses/domain/entities/course_entity.dart';
import 'package:injectable/injectable.dart';
import 'course_data_interface.dart';

@LazySingleton(as: CourseDataInterface)
class LocalCourseData implements CourseDataInterface {
  final List<CourseEntity> fixedCoursesData = [
    CourseEntity(
      courseName: 'Flutter',
      courseType: 'Programming',
      publishDate: '2020-20-1',
      courseID: 1,
    ),
    CourseEntity(
      courseName: 'Excel',
      courseType: 'Business',
      publishDate: '2021-20-1',
      courseID: 2,
    ),
  ];

  late List<CourseEntity> coursesData;

  LocalCourseData() {
    coursesData = fixedCoursesData.toList();
  }

  @override
  Future<CourseResponse> deleteCourse(CourseEntity courseData) async {
    final index = coursesData.indexWhere(
      (course) => course.courseID == courseData.courseID,
    );
    if (index != -1) {
      final removed = coursesData.removeAt(index);
      print('Course deleted: ${removed.courseName}');
      return CourseResponse(
        courseName: removed.courseName,
        courseType: removed.courseType,
        publishDate: removed.publishDate,
        courseID: removed.courseID,
      );
    } else {
      throw Exception('Course not found');
    }
  }

  @override
  Future<List<CourseResponse>> showCourses() async {
    print('Courses List Length: ${coursesData.length}');
    for (var course in coursesData) {
      print(
        '-> ID: ${course.courseID}, Name: ${course.courseName}, Type: ${course.courseType}, Date: ${course.publishDate}',
      );
    }
    return coursesData
        .map(
          (course) => CourseResponse(
            courseName: course.courseName,
            courseType: course.courseType,
            publishDate: course.publishDate,
            courseID: course.courseID,
          ),
        )
        .toList();
  }
}
