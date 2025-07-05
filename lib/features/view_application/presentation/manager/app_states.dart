
import 'package:hireny/features/view_application/domain/model/user_application.dart';

abstract class AppState{}

class InitUserAppState extends AppState{}

class LoadingUserAppState extends AppState{}

class ErrorUserAppState extends AppState{}

class SuccessUserAppState extends AppState{
  List<SeekerApplication> applications;
  SuccessUserAppState(this.applications);
}
class HideUserAppState extends AppState{}