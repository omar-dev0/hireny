import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';
import 'package:hireny/features/show_admin/domain/repositories/admin_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAdmins {
  AdminRepoInterface adminRepo;

  GetAdmins({required this.adminRepo});
  Future<List<AdminEntity>> call() async {
    return await adminRepo.showAdmins();
  }
}
