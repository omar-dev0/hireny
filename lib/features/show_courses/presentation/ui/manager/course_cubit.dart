import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_courses/domain/usecases/delete_course.dart';
import 'package:hireny/features/show_courses/domain/usecases/show_courses.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/course_entity.dart';
import 'course_states.dart';

@injectable
class CourseCubit extends Cubit<CourseStates> {
  final DeleteCourse removeCourse;
  final ShowCourses listCourses;
  List<CourseEntity> courses = [];




  @factoryMethod
  CourseCubit(this.removeCourse, this.listCourses) : super(InitialState());

  Future<void> loadCourses() async {
    try {
      emit(LoadingState());
      courses = await listCourses.call();
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load courses"));
    }
  }


  Future<void> deleteCourse(CourseEntity course) async {
    try {
      await removeCourse.call(course);
      emit(SuccessState());
      await loadCourses();
    } catch (e) {
      emit(ErrorState("Failed to delete course: ${e.toString()}"));
    }
  }
}
