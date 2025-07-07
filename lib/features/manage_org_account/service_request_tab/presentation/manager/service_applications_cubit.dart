import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/domain/repo/service_applications_repo_interface.dart';
import 'package:hireny/features/manage_org_account/service_request_tab/presentation/manager/service_applications_states.dart';
import 'package:injectable/injectable.dart';
import 'package:intl/intl.dart';

import '../../../../../utils/data_shared/app_shared_data.dart';

@injectable
class ServiceApplicationsCubit extends Cubit<ServiceApplicationsStates> {
  final ServiceApplicationsRepoInterface serviceApplicationsRepoInterface;

  @factoryMethod
  ServiceApplicationsCubit(this.serviceApplicationsRepoInterface)
      : super(InitialState());

  Future<void> getApplications() async {
    emit(LoadingState());

    try {
      await serviceApplicationsRepoInterface.getServiceApplications();
      emit(SuccessState());
    } catch (e) {
      emit(ErrorState(e.toString()));
    }
  }

  Future<void> deleteApplication(int id) async {
    emit(LoadingState());

    try {
      await serviceApplicationsRepoInterface.deleteServiceApplication(id);

      // Remove from shared list
      AppSharedData.serviceApplications
          .removeWhere((application) => application.id == id);

      emit(SuccessState());
    } catch (e) {
      emit(ErrorState('Failed to delete application: $e'));
    }
  }
  String getFormattedDateOnly(String? rawDate) {
    try {
      final date = DateTime.parse(rawDate ?? '');
      return DateFormat('yyyy-MM-dd').format(date);
    } catch (_) {
      return 'Invalid date';
    }
  }


}
