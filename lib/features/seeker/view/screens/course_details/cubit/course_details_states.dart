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

class LoadReviewCourse extends CourseDetailsState {}
class SuccessLoadedReviews extends CourseDetailsState {}
class ErrorLoadedReviews extends CourseDetailsState {
  final String error;
  ErrorLoadedReviews(this.error);
}
class LoadingAddCourseReview extends CourseDetailsState {}
class SuccessAddCourseReview extends CourseDetailsState {}
class HideDialogCourseReview extends CourseDetailsState {}
class ErrorAddCourseReview extends CourseDetailsState {
  final String error;
  ErrorAddCourseReview(this.error);
}

