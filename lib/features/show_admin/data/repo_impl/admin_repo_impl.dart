import 'package:hireny/features/show_admin/data/data_sources/admin_data_interface.dart';
import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';
import 'package:hireny/features/show_admin/domain/repositories/admin_repo_interface.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AdminRepoInterface)
class AdminRepoImpl implements AdminRepoInterface {
  final AdminDataInterface admin;
  AdminRepoImpl(this.admin);

  @override
  Future<void> deleteAdmin(AdminEntity adminData) async {
    return await admin.deleteAdmin(adminData);
  }

  @override
  Future<List<AdminEntity>> showAdmins() async {
    return await admin.showAdmin();
  }
}
