import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_application/domain/entities/application_entity.dart';
import 'package:hireny/features/view_application/domain/usecases/delete_app.dart';
import 'package:hireny/features/view_application/presentation/manager/app_states.dart';

import 'package:injectable/injectable.dart';

import '../../domain/usecases/show_app.dart';

@injectable
class AppCubit extends Cubit<AppStates> {
  final DeleteApp removeApp;
  final ShowApp listApp;
  List<AppEntity> applications = [];




  @factoryMethod
  AppCubit(this.removeApp, this.listApp) : super(InitialState());

  Future<void> loadApplications() async {
    try {
      emit(LoadingState());
      applications = await listApp.call();
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState("Failed to load applications"));
    }
  }


  Future<void> deleteCourse(AppEntity app) async {
    try {
      await removeApp.call(app);
      emit(SuccessState());
      await loadApplications();
    } catch (e) {
      emit(ErrorState("Failed to delete application: ${e.toString()}"));
    }
  }
}
