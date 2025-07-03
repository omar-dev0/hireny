part of 'my_courses_cubit.dart';

@immutable
sealed class MyCoursesState {}

final class MyCoursesInitial extends MyCoursesState {}

final class MyCoursesLoading extends MyCoursesState {}

final class MyCoursesSuccess extends MyCoursesState {}

final class MyCoursesFailure extends MyCoursesState {
  String? message;
  MyCoursesFailure(this.message);
}
