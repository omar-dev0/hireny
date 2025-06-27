import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_courses/domain/usecases/delete_course.dart';
import 'package:hireny/features/show_courses/domain/usecases/show_courses.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/course_entity.dart';
import 'course_seeker_state.dart';

@injectable
class SeekerCoursesCubit extends Cubit<SeekerCoursesSate> {
  final DeleteCourse removeCourse;
  final ShowCourses listCourses;
  List<CourseEntity> courses = [];




  @factoryMethod
  SeekerCoursesCubit(this.removeCourse, this.listCourses) : super(InitSeekerCourse());

  Future<void> loadCourses() async {
    try {
      emit(LoadingSeekerCourse());
      courses = await listCourses.call();
      emit(SuccessSeekerCourse());
    } catch (e) {
      emit(ErrorSeekerCourse("Failed to load courses"));
    }
  }


  Future<void> deleteCourse(CourseEntity course) async {
    try {
      await removeCourse.call(course);
      emit(SuccessSeekerCourse());
      await loadCourses();
    } catch (e) {
      emit(ErrorSeekerCourse("Failed to delete course: ${e.toString()}"));
    }
  }
}
