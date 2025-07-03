import '../../../../domain/modules/course.dart';

abstract class CourseDetailsState {}

class CourseDetailsInitial extends CourseDetailsState {}

class CourseDetailsLoading extends CourseDetailsState {}

class CourseDetailsLoaded extends CourseDetailsState {
  final Course? courseDetails;
  CourseDetailsLoaded({required this.courseDetails});
}

class CourseDetailsError extends CourseDetailsState {
  final String message;
  CourseDetailsError({required this.message});
}
