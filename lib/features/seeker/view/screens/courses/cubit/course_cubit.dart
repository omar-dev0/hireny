import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/course.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'course_states.dart';

@injectable
@injectable
class CourseCubit extends Cubit<CourseState> {
  final SeekerRepository courseRepository;

  CourseCubit(this.courseRepository) : super(CourseInitial());

  Future<void> fetchNotRegisteredCourses() async {
    emit(CourseLoading());
    try {
      final result = await courseRepository.getNotRegisteredCourses();

      if (result is Success<List<Course>>) {
        AppSharedData.courses = result.response ?? [];

        emit(CourseLoaded(courses: result.response ?? []));
      } else if (result is Error<List<Course>>) {
        emit(CourseError(message: "An error occurred"));
      }
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }

  void filterCourses(String query) {
    if (query.isEmpty) {
      emit(CourseLoaded(courses: AppSharedData.courses));
      return;
    }

    final filteredList =
        AppSharedData.courses
            .where(
              (course) =>
                  course.title.toLowerCase().contains(query.toLowerCase()),
            )
            .toList();

    emit(CourseLoaded(courses: filteredList));
  }
}
