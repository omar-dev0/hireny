import '../../../../domain/modules/course.dart';

abstract class CourseState {}

class CourseInitial extends CourseState {}
class CourseLoading extends CourseState {}
class CourseLoaded extends CourseState {
  final List<Course> courses;
  CourseLoaded({required this.courses});
}
class CourseError extends CourseState {
  final String message;
  CourseError({required this.message});
}