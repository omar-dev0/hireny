import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../../../../domain/modules/course.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';

import 'course_details_states.dart';

@injectable
class CourseDetailsCubit extends Cubit<CourseDetailsState> {
  final SeekerRepository seekerRepository;

  CourseDetailsCubit(this.seekerRepository) : super(CourseDetailsInitial());

  Future<void> fetchCourseDetails(int courseId) async {
    emit(CourseDetailsLoading());
    try {
      final result = await seekerRepository.getCourseDetails(courseId);

      if (result is Success<Course>) {
        emit(CourseDetailsLoaded(courseDetails: result.response));
      } else if (result is Error<Course>) {
        emit(CourseDetailsError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(CourseDetailsError(message: e.toString()));
    }
  }
}
