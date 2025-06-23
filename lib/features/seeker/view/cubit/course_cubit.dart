import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../domain/modules/course.dart';
import '../../domain/repo_contract/course_repository.dart';
import 'course_states.dart';

@injectable
class CourseCubit extends Cubit<CourseState> {
  final CourseRepository courseRepository;

  CourseCubit(this.courseRepository) : super(CourseInitial());

  Future<void> fetchNotRegisteredCourses() async {
    emit(CourseLoading());
    try {
      final result = await courseRepository.getNotRegisteredCourses();

      if (result is Success<List<Course>>) {
        emit(CourseLoaded(courses: result.data));
      } else if (result is Error<List<Course>>) {
        emit(CourseError(message: "An error occurred"));
      }
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }
}