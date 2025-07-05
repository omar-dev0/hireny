import '../../../../result.dart';
import '../../domain/model/user_application.dart';

abstract class ApplicationDataSource{
  Future<Result<List<SeekerApplication>>?> getUserApplication();
}