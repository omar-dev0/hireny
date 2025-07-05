import '../../../../result.dart';
import '../model/user_application.dart';

abstract class ApplicationRepo{
  Future<Result<List<SeekerApplication>>?> getUserApplication();
}