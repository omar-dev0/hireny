import '../entities/admin_entity.dart';

abstract class AdminRepoInterface{
  Future<void> deleteAdmin(AdminEntity adminData);
  Future<List<AdminEntity>> showAdmins();
}