import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_courses/domain/usecases/show_courses.dart';
import 'package:injectable/injectable.dart';
import '../../../domain/entities/course_entity.dart';
import 'course_seeker_state.dart';

@injectable
class SeekerCoursesCubit extends Cubit<SeekerCoursesSate> {
  final ShowCourses listCourses;
  List<CourseEntity> courses = [];

  @factoryMethod
  SeekerCoursesCubit(this.listCourses)
    : super(InitSeekerCourse());

  Future<void> loadCourses() async {
    try {
      emit(LoadingSeekerCourse());
      await listCourses.call();
      emit(SuccessSeekerCourse());
    } catch (e) {
      emit(ErrorSeekerCourse("Failed to load courses"));
    }
  }

}
