import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../result.dart';
import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/service.dart';
import '../../../../domain/repo_contract/org_repository.dart';
import 'explore_services_states.dart';

@injectable
class ExploreServicesCubit extends Cubit<ExploreServicesState> {
  final OrgRepository orgRepository;

  ExploreServicesCubit(this.orgRepository) : super(ExploreServicesInitial());

  Future<void> fetchAllServices() async {
    emit(ExploreServicesLoading());
    try {
      final Result<List<ServiceModel>> result = await orgRepository.getNotAppliedServicePosts();

      if (result is Success<List<ServiceModel>>) {
        AppSharedData.services = result.response ?? [];

        emit(ServicesLoaded(services: result.response ?? []));
      } else if (result is Error<List<ServiceModel>>) {
        emit(ServicesError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(ServicesError(message: e.toString()));
    }
  }


  void filterServices(String query) {
    if (query.isEmpty) {
      emit(ServicesLoaded(services: AppSharedData.services));
      return;
    }

    final filteredList = AppSharedData.services
        .where((service) =>
    service.serviceTitle?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    emit(ServicesLoaded(services: filteredList));
  }
}