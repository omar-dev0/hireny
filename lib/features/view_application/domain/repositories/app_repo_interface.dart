import 'package:hireny/features/view_application/domain/entities/application_entity.dart';

abstract class AppRepoInterface {
  Future<List<AppEntity>> showApplications();
  Future<void> deleteApplication(AppEntity appData);
}
