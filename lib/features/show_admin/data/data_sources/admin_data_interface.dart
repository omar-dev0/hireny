import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';

abstract class AdminDataInterface {
  Future<List<AdminEntity>> showAdmin();
  Future<void> addAmin(AdminEntity admin);
  Future<void> deleteAdmin(AdminEntity admin);
}
