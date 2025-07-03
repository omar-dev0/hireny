import 'package:hireny/features/show_admin/data/data_sources/admin_data_interface.dart';
import 'package:hireny/features/show_admin/data/models/admin_response.dart';
import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';
import 'package:injectable/injectable.dart';

@LazySingleton(as: AdminDataInterface)
class AdminLocalDataSource implements AdminDataInterface {
  final List<AdminEntity> fixedAdminData = [
    AdminEntity(
      adminID: 1,
      adminName: "Adam",
      adminEmail: "adam@gmail.com",
      adminDate: "09-11-2020",
    ),
    AdminEntity(
      adminID: 2,
      adminName: "Adam",
      adminEmail: "adam@gmail.com",
      adminDate: "09-11-2020",
    ),
    AdminEntity(
      adminID: 3,
      adminName: "Adam",
      adminEmail: "adam@gmail.com",
      adminDate: "09-11-2020",
    ),
  ];

  late List<AdminEntity> adminsData;

  AdminLocalDataSource() {
    adminsData = fixedAdminData.toList();
  }

  @override
  Future<void> addAmin(AdminEntity admin) {
    // TODO: implement addAmin
    throw UnimplementedError();
  }

  @override
  Future<void> deleteAdmin(AdminEntity adminEntity) async {
    final index = adminsData.indexWhere(
      (admin) => adminEntity.adminID == admin.adminID,
    );
    if (index != -1) {
      final removed = adminsData.removeAt(index);
    } else {
      throw Exception('Admin not found');
    }
  }

  @override
  Future<List<AdminEntity>> showAdmin() async {
    return adminsData
        .map(
          (admin) => AdminResponse(
            adminName: admin.adminName,
            adminID: admin.adminID,
            adminEmail: admin.adminEmail,
            adminDate: admin.adminDate,
          ),
        )
        .toList();
  }
}
