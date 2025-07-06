import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/organization/domain/modules/organization.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../result.dart';
import '../../../../../seeker/domain/modules/org_post.dart';
import '../../../../domain/modules/seeker.dart';
import '../../../../domain/repo_contract/org_repository.dart';
import 'explore_organizations_org_states.dart';

@injectable
class ExploreOrganizationsOrgCubit extends Cubit<ExploreOrganizationsOrgState> {
  final OrgRepository orgRepository;

  // Current filters - follow the same pattern as JobPostCubit
  Map<String, dynamic> _currentFilters = {
    'location': <int>{}, // Changed from String to Set<int> for consistency
    'industry': <int>{},
    'size': <int>{},
  };

  ExploreOrganizationsOrgCubit(this.orgRepository) : super(ExploreOrganizationsOrgInitial());

  Future<void> fetchAllOrgs() async {
    emit(ExploreOrganizationsOrgLoading());
    try {
      final Result<List<OrgPost>> result = await orgRepository.getAllOrganizations();
      if (result is Success<List<OrgPost>>) {
        AppSharedData.orgs = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<OrgPost>>) {
        emit(ExploreOrganizationsOrgError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(ExploreOrganizationsOrgError(message: e.toString()));
    }
  }

  /// Filter organizations by name based on search query
  void filterOrgs(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList = AppSharedData.orgs
        .where((orgPost) => orgPost.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(ExploreOrganizationsOrgLoaded(orgs: filteredList));
  }

  void updateLocationFilter(Set<int> selectedIndices) {
    _currentFilters['location'] = selectedIndices;
    _applyFilters();
  }

  void updateIndustryFilter(Set<int> selectedIndices) {
    _currentFilters['industry'] = selectedIndices;
    _applyFilters();
  }

  void updateSizeFilter(Set<int> selectedIndices) {
    _currentFilters['size'] = selectedIndices;
    _applyFilters();
  }


  void _applyFilters() {
    List<OrgPost> filteredList = List.from(AppSharedData.orgs);

    // Apply location filter
    Set<int> selectedLocationIndices = _currentFilters['location'];
    if (selectedLocationIndices.isNotEmpty) {
      final List<String> allLocations = AppSharedData.countries; // Assuming you have this in AppSharedData
      final List<String> selectedLocations = selectedLocationIndices
          .map((i) => allLocations[i].toLowerCase())
          .toList();

      filteredList = filteredList
          .where((org) => selectedLocations.contains(org.country.toLowerCase()))
          .toList();
    }

    // Apply industry filter
    Set<int> selectedIndustryIndices = _currentFilters['industry'];
    if (selectedIndustryIndices.isNotEmpty) {
      final List<String> allIndustries = AppSharedData.industries;
      final List<String> selectedIndustries = selectedIndustryIndices
          .map((i) => allIndustries[i].toLowerCase())
          .toList();

      filteredList = filteredList
          .where((org) => selectedIndustries.contains(org.industry.toLowerCase()))
          .toList();
    }

    // Apply size filter
    Set<int> selectedSizeIndices = _currentFilters['size'];
    if (selectedSizeIndices.isNotEmpty) {
      final List<String> allSizes = AppSharedData.organizationSizes; // Assuming you have this in AppSharedData
      final List<String> selectedSizes = selectedSizeIndices
          .map((i) => allSizes[i])
          .toList();

      filteredList = filteredList
          .where((org) => selectedSizes.contains(org.organizationSize))
          .toList();
    }



    emit(ExploreOrganizationsOrgLoaded(orgs: filteredList));
  }


  // Getters for current filter selections (for UI to pre-populate bottom sheets)
  Set<int> get selectedLocationIndices => _currentFilters['location'];
  Set<int> get selectedIndustryIndices => _currentFilters['industry'];
  Set<int> get selectedSizeIndices => _currentFilters['size'];
}