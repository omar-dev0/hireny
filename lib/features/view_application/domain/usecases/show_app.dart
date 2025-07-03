import 'package:injectable/injectable.dart';

import '../entities/application_entity.dart';
import '../repositories/app_repo_interface.dart';

@injectable
class ShowApp {
  AppRepoInterface appRepo;

  ShowApp({required this.appRepo});
  Future<List<AppEntity>> call() async {
    return await appRepo.showApplications();
  }
}
