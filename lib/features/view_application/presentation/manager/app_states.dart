abstract class AppStates{}
class InitialState extends AppStates{}
class LoadingState extends AppStates{}
class SuccessState extends AppStates{}

class ErrorState extends AppStates{
  String? message;
  ErrorState(this.message);
}
