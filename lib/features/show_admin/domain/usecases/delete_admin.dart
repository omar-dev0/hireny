
import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';
import 'package:hireny/features/show_admin/domain/repositories/admin_repo_interface.dart';
import 'package:injectable/injectable.dart';

@injectable
class DeleteAdmin{
  AdminRepoInterface adminRepo;

  DeleteAdmin({required this.adminRepo});
  Future<void> call(AdminEntity adminData) async {
    return await adminRepo.deleteAdmin(adminData);
  }
}