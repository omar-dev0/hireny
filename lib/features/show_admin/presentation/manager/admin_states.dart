abstract class AdminStates{}
class InitialState extends AdminStates{}
class LoadingState extends AdminStates{}
class SuccessState extends AdminStates{}

class ErrorState extends AdminStates{
  String? message;
  ErrorState(this.message);
}
