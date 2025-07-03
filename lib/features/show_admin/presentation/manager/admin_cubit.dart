import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/show_admin/domain/entities/admin_entity.dart';
import 'package:hireny/features/show_admin/domain/usecases/delete_admin.dart';
import 'package:hireny/features/show_admin/domain/usecases/get_admins.dart';
import 'package:hireny/features/show_admin/presentation/manager/admin_states.dart';
import 'package:injectable/injectable.dart';

@injectable
class AdminCubit extends Cubit<AdminStates> {
  final GetAdmins listAdmins;
  final DeleteAdmin removeAdmin;
  List<AdminEntity> admins = [];

  AdminCubit(this.listAdmins, this.removeAdmin) : super(InitialState());

  Future<void> loadAdmins() async {
    try {
      emit(LoadingState());
      admins = await listAdmins.call();
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load courses"));
    }
  }

  Future<void> deleteCourse(AdminEntity admin) async {
    try {
      await removeAdmin.call(admin);
      emit(SuccessState());
      await loadAdmins();
    } catch (e) {
      emit(ErrorState("Failed to delete admin: ${e.toString()}"));
    }
  }
}
