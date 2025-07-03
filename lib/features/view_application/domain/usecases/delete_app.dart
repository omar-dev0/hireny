import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:hireny/features/view_application/domain/repositories/app_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteApp {
  AppRepoInterface appRepo;

  DeleteApp({required this.appRepo});
  Future<void> call(AppEntity appData) async {
    return await appRepo.deleteApplication(appData);
  }
}
