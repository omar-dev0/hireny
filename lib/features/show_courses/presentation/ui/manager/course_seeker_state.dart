abstract class SeekerCoursesSate {}

class InitSeekerCourse extends SeekerCoursesSate {}

class LoadingSeekerCourse extends SeekerCoursesSate {}

class SuccessSeekerCourse extends SeekerCoursesSate {}

class ErrorSeekerCourse extends SeekerCoursesSate {
  String? message;
  ErrorSeekerCourse(this.message);
}
