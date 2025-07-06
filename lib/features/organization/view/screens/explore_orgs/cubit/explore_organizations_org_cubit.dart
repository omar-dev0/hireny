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

    print("🔍 Filtered organizations by name with query: '$query'");
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

      print("### DEBUG: Applying Location Filter ###");
      print("Selected indices: $selectedLocationIndices");
      print("All locations: $allLocations");
      print("Selected locations: $selectedLocations");

      filteredList = filteredList
          .where((org) {
        bool matched = selectedLocations.contains(org.country?.toLowerCase() ?? '');
        if (matched) {
          print("✅ Matched location: '${org.country}' for organization '${org.name}'");
        } else {
          print("❌ No match for location: '${org.country}' not in '$selectedLocations'");
        }
        return matched;
      })
          .toList();
    }

    // Apply industry filter
    Set<int> selectedIndustryIndices = _currentFilters['industry'];
    if (selectedIndustryIndices.isNotEmpty) {
      final List<String> allIndustries = AppSharedData.industries;
      final List<String> selectedIndustries = selectedIndustryIndices
          .map((i) => allIndustries[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Industry Filter ###");
      print("Selected indices: $selectedIndustryIndices");
      print("All industries: $allIndustries");
      print("Selected industries: $selectedIndustries");

      filteredList = filteredList
          .where((org) {
        bool matched = selectedIndustries.contains(org.industry?.toLowerCase() ?? '');
        if (matched) {
          print("✅ Matched industry: '${org.industry}' for organization '${org.name}'");
        } else {
          print("❌ No match for industry: '${org.industry}' not in '$selectedIndustries'");
        }
        return matched;
      })
          .toList();
    }

    // Apply size filter
    Set<int> selectedSizeIndices = _currentFilters['size'];
    if (selectedSizeIndices.isNotEmpty) {
      final List<String> allSizes = AppSharedData.organizationSizes; // Assuming you have this in AppSharedData
      final List<String> selectedSizes = selectedSizeIndices
          .map((i) => allSizes[i])
          .toList();

      print("### DEBUG: Applying Size Filter ###");
      print("Selected indices: $selectedSizeIndices");
      print("All sizes: $allSizes");
      print("Selected sizes: $selectedSizes");

      filteredList = filteredList
          .where((org) {
        bool matched = selectedSizes.contains(org.organizationSize);
        if (matched) {
          print("✅ Matched size: '${org.organizationSize}' for organization '${org.name}'");
        } else {
          print("❌ No match for size: '${org.organizationSize}' not in '$selectedSizes'");
        }
        return matched;
      })
          .toList();
    }

    emit(ExploreOrganizationsOrgLoaded(orgs: filteredList));
  }

  // Getters for current filter selections (for UI to pre-populate bottom sheets)
  Set<int> get selectedLocationIndices => _currentFilters['location'];
  Set<int> get selectedIndustryIndices => _currentFilters['industry'];
  Set<int> get selectedSizeIndices => _currentFilters['size'];
}