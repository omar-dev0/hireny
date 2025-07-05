import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/view_application/domain/model/user_application.dart';
import 'package:hireny/features/view_application/domain/repo_contract/application_repo_contratc.dart';
import 'package:hireny/features/view_application/presentation/manager/app_states.dart';
import 'package:hireny/result.dart';

import 'package:injectable/injectable.dart';

@injectable
class AppCubit extends Cubit<AppState> {
  ApplicationRepo applicationRepo;
  @factoryMethod
  AppCubit(this.applicationRepo) : super(InitUserAppState());

  Future<void> getUserApplication() async {
    try {
      emit(LoadingUserAppState());
      final result = await applicationRepo.getUserApplication();
      switch (result) {
        case null:
          {
            emit(ErrorUserAppState());
          }
        case Success<List<SeekerApplication>>():
          {
            emit(SuccessUserAppState(result.response ?? []));
          }
        case Error<List<SeekerApplication>>():
          {
            emit(ErrorUserAppState());
          }
      }
    } catch (e) {
      emit(ErrorUserAppState());
    }
  }
}
