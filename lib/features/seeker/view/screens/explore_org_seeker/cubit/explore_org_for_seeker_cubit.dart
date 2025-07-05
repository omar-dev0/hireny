import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../result.dart';
import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/org_post.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'explore_org_for_seeker_states.dart';

@injectable
class OrgPostCubit extends Cubit<OrgPostState> {
  final SeekerRepository seekerRepository;

  OrgPostCubit(this.seekerRepository) : super(OrgPostInitial());

  Map<String, dynamic> _currentFilters = {
    'location': <int>{},
    'industry': <int>{},
    'size': <int>{},
    'date': 'All',
  };

  Future<void> fetchAllOrganizations() async {
    emit(OrgPostLoading());
    try {
      final result = await seekerRepository.getAllOrganizations();

      if (result is Success<List<OrgPost>>) {
        AppSharedData.orgPosts = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<OrgPost>>) {
        emit(OrgPostError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(OrgPostError(message: e.toString()));
    }
  }

  void filterOrgPosts(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList = AppSharedData.orgPosts
        .where((orgPost) =>
        orgPost.name.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(OrgPostLoaded(orgPosts: filteredList));
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

  void updateDateFilter(String selectedDate) {
    _currentFilters['date'] = selectedDate;
    _applyFilters();
  }

  void _applyFilters() {
    List<OrgPost> filteredList = List.from(AppSharedData.orgPosts);

    // Apply location filter
    Set<int> selectedLocationIndices = _currentFilters['location'];
    if (selectedLocationIndices.isNotEmpty) {
      final List<String> allLocations = AppSharedData.countries; // Assuming AppSharedData.countries holds locations
      final List<String> selectedLocations = selectedLocationIndices.map((i) => allLocations[i]).toList();
      filteredList = filteredList
          .where((orgPost) =>
          selectedLocations.contains(orgPost.country.toLowerCase()))
          .toList();
    }

    // Apply industry filter
    Set<int> selectedIndustryIndices = _currentFilters['industry'];
    if (selectedIndustryIndices.isNotEmpty) {
      final List<String> allIndustries = AppSharedData.industries;
      final List<String> selectedIndustries = selectedIndustryIndices.map((i) => allIndustries[i].toLowerCase()).toList();
      filteredList = filteredList
          .where((orgPost) =>
          selectedIndustries.contains(orgPost.industry.toLowerCase()))
          .toList();
    }

    // Apply size filter
    Set<int> selectedSizeIndices = _currentFilters['size'];
    if (selectedSizeIndices.isNotEmpty) {
      final List<String> allSizes = AppSharedData.organizationSizes;
      final List<String> selectedSizes = selectedSizeIndices.map((i) => allSizes[i]).toList();
      filteredList = filteredList
          .where((orgPost) =>
          selectedSizes.contains(orgPost.organizationSize.toLowerCase()))
          .toList();
    }

    // Apply date filter
    String selectedDate = _currentFilters['date'];
    if (selectedDate != 'All') {
      filteredList = filteredList
          .where((o) => _isWithinDateRange(o.createdAt, selectedDate))
          .toList();
    }

    emit(OrgPostLoaded(orgPosts: filteredList));
  }

  bool _isWithinDateRange(String dateStr, String selectedDate) {
    DateTime date = DateTime.parse(dateStr);
    DateTime now = DateTime.now();

    switch (selectedDate) {
      case 'Last Hour':
        return date.isAfter(now.subtract(Duration(hours: 1)));
      case 'Last 24 Hours':
        return date.isAfter(now.subtract(Duration(hours: 24)));
      case 'Last 7 Days':
        return date.isAfter(now.subtract(Duration(days: 7)));
      case 'Last 30 Days':
        return date.isAfter(now.subtract(Duration(days: 30)));
      default:
        return true;
    }
  }

  // Getters for current filter selections (for UI to pre-populate bottom sheets)
  Set<int> get selectedLocationIndices => _currentFilters['location'];
  Set<int> get selectedIndustryIndices => _currentFilters['industry'];
  Set<int> get selectedSizeIndices => _currentFilters['size'];
  String get selectedDateFilter => _currentFilters['date'];
}


