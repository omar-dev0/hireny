import 'package:hireny/features/view_application/data/models/app_response.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';

abstract class AppDataInterface {
  Future<List<AppResponse>> showApplications();
  Future<void> deleteApplication(AppEntity appData);
}
