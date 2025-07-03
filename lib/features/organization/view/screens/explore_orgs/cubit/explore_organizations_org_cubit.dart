import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/organization/domain/modules/organization.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../result.dart';
import '../../../../domain/modules/seeker.dart';
import '../../../../domain/repo_contract/org_repository.dart';
import 'explore_organizations_org_states.dart';

@injectable
class ExploreOrganizationsOrgCubit extends Cubit<ExploreOrganizationsOrgState> {
  final OrgRepository orgRepository;

  ExploreOrganizationsOrgCubit(this.orgRepository) : super(ExploreOrganizationsOrgInitial());

  Future<void> fetchAllOrgs() async {
    emit(ExploreOrganizationsOrgLoading());
    try {
      final Result<List<OrgPostOrg>> result = await orgRepository.getAllOrganizations();

      if (result is Success<List<OrgPostOrg>>) {
        AppSharedData.orgs = result.response ?? [];

        emit(ExploreOrganizationsOrgLoaded(orgs: result.response ?? []));
      } else if (result is Error<List<OrgPostOrg>>) {
        emit(ExploreOrganizationsOrgError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(ExploreOrganizationsOrgError(message: e.toString()));
    }
  }

  /// Filter seekers by name or job title based on search query
  void filterOrgs(String query) {
    if (query.isEmpty) {
      emit(ExploreOrganizationsOrgLoaded(orgs: AppSharedData.orgs));
      return;
    }

    final filteredList = AppSharedData.orgs
        .where((orgPost) =>
        orgPost.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(ExploreOrganizationsOrgLoaded(orgs: filteredList));
  }
}