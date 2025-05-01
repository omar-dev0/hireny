abstract class CourseStates{}
class InitialState extends CourseStates{}
class LoadingState extends CourseStates{}
class SuccessState extends CourseStates{}

class ErrorState extends CourseStates{
  String? message;
  ErrorState(this.message);
}
