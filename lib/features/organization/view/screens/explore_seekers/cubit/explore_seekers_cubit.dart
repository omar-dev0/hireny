import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/seeker/domain/repo_contract/seeker_repository.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../result.dart';
import '../../../../../../utils/constants/helper_functions.dart';
import '../../../../domain/modules/seeker.dart';
import '../../../../domain/repo_contract/org_repository.dart';
import 'explore_seekers_states.dart';

@injectable
class ExploreSeekersCubit extends Cubit<SeekerPostState> {
  final OrgRepository orgRepository;

  // Current filters - following the same pattern as JobPostCubit
  Map<String, dynamic> _currentFilters = {
    'location': <int>{}, // multiple selection
    'industry': <int>{}, // multiple selection
    'careerLevel': <int>{}, // multiple selection
    'employmentStatus': <int>{}, // multiple selection
    'gender': <int>{}, // single or multiple selection
    'minAge': null,
    'maxAge': null,
  };

  ExploreSeekersCubit(this.orgRepository) : super(SeekerPostInitial());

  Future<void> fetchAllSeekers() async {
    emit(SeekerPostLoading());
    try {
      final Result<List<SeekerModel>> result = await orgRepository.getAllSeekers();

      if (result is Success<List<SeekerModel>>) {
        AppSharedData.seekers = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<SeekerModel>>) {
        emit(SeekerPostError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(SeekerPostError(message: e.toString()));
    }
  }

  /// Filter seekers by name or job title based on search query
  void filterSeekers(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList = AppSharedData.seekers
        .where((seeker) =>
    seeker.user?.firstName?.toLowerCase().contains(query.toLowerCase()) == true ||
        seeker.title?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    emit(SeekerLoaded(seekers: filteredList));
  }

  void updateLocationFilter(Set<int> selectedIndices) {
    _currentFilters['location'] = selectedIndices;
    _applyFilters();
  }

  void updateIndustryFilter(Set<int> selectedIndices) {
    _currentFilters['industry'] = selectedIndices;
    _applyFilters();
  }

  void updateCareerLevelFilter(Set<int> selectedIndices) {
    _currentFilters['careerLevel'] = selectedIndices;
    _applyFilters();
  }

  void updateEmploymentStatusFilter(Set<int> selectedIndices) {
    _currentFilters['employmentStatus'] = selectedIndices;
    _applyFilters();
  }

  void updateGenderFilter(Set<int> selectedIndices) {
    _currentFilters['gender'] = selectedIndices;
    _applyFilters();
  }

  void updateAgeRangeFilter({String? min, String? max}) {
    _currentFilters['minAge'] = min;
    _currentFilters['maxAge'] = max;
    _applyFilters();
  }

  void _applyFilters() {
    List<SeekerModel> filteredList = List.from(AppSharedData.seekers);

    // Apply location filter
    Set<int> selectedLocationIndices = _currentFilters['location'];
    if (selectedLocationIndices.isNotEmpty) {
      final List<String> allLocations = AppSharedData.countries;
      final List<String> selectedLocations = selectedLocationIndices
          .map((i) => allLocations[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Location Filter ###");
      print("Selected indices: $selectedLocationIndices");
      print("All locations: $allLocations");
      print("Selected locations: $selectedLocations");

      filteredList = filteredList
          .where((seeker) {
        bool matched = selectedLocations.contains(seeker.country?.toLowerCase());
        if (matched) {
          print("✅ Matched location: '${seeker.country}' for seeker '${seeker.user?.firstName}'");
        } else {
          print("❌ No match for location: '${seeker.country}' not in '$selectedLocations'");
        }
        return matched;
      })
          .toList();
    }

    // // Apply industry filter
    // Set<int> selectedIndustryIndices = _currentFilters['industry'];
    // if (selectedIndustryIndices.isNotEmpty) {
    //   final List<String> allIndustries = AppSharedData.industries;
    //   final List<String> selectedIndustries = selectedIndustryIndices
    //       .map((i) => allIndustries[i].toLowerCase())
    //       .toList();
    //
    //   print("### DEBUG: Applying Industry Filter ###");
    //   print("Selected indices: $selectedIndustryIndices");
    //   print("All industries: $allIndustries");
    //   print("Selected industries: $selectedIndustries");
    //
    //   filteredList = filteredList
    //       .where((seeker) {
    //     bool matched = selectedIndustries.contains(seeker.title?.toLowerCase());
    //     if (matched) {
    //       print("✅ Matched industry: '${seeker.title}' for seeker '${seeker.user?.firstName}'");
    //     } else {
    //       print("❌ No match for industry: '${seeker.title}' not in '$selectedIndustries'");
    //     }
    //     return matched;
    //   })
    //       .toList();
    // }

    // Apply career level filter
    Set<int> selectedCareerLevelIndices = _currentFilters['careerLevel'];
    if (selectedCareerLevelIndices.isNotEmpty) {
      final List<String> allLevels = AppSharedData.careerLevels;
      final List<String> selectedLevels = selectedCareerLevelIndices
          .map((i) => allLevels[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Career Level Filter ###");
      print("Selected indices: $selectedCareerLevelIndices");
      print("All career levels: $allLevels");
      print("Selected career levels: $selectedLevels");

      filteredList = filteredList
          .where((seeker) {
        bool matched = selectedLevels.contains(seeker.careerLevel?.toLowerCase());
        if (matched) {
          print("✅ Matched career level: '${seeker.careerLevel}' for seeker '${seeker.user?.firstName}'");
        } else {
          print("❌ No match for career level: '${seeker.careerLevel}' not in '$selectedLevels'");
        }
        return matched;
      })
          .toList();
    }

    // Apply employment status filter
    Set<int> selectedEmploymentIndices = _currentFilters['employmentStatus'];
    if (selectedEmploymentIndices.isNotEmpty) {
      final List<String> allStatuses = AppSharedData.employmentStatus;
      final List<String> selectedStatuses = selectedEmploymentIndices
          .map((i) => allStatuses[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Employment Status Filter ###");
      print("Selected indices: $selectedEmploymentIndices");
      print("All statuses: $allStatuses");
      print("Selected statuses: $selectedStatuses");

      filteredList = filteredList
          .where((seeker) {
        bool matched = selectedStatuses.contains(seeker.employmentStatus?.toLowerCase());
        if (matched) {
          print("✅ Matched employment status: '${seeker.employmentStatus}' for seeker '${seeker.user?.firstName}'");
        } else {
          print("❌ No match for employment status: '${seeker.employmentStatus}' not in '$selectedStatuses'");
        }
        return matched;
      })
          .toList();
    }

    // Apply gender filter
    Set<int> selectedGenderIndices = _currentFilters['gender'];
    if (selectedGenderIndices.isNotEmpty) {
      final List<String> allGenders = ["Male", "Female"];
      final List<String> selectedGenders = selectedGenderIndices
          .map((i) => allGenders[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Gender Filter ###");
      print("Selected indices: $selectedGenderIndices");
      print("All genders: $allGenders");
      print("Selected genders: $selectedGenders");

      filteredList = filteredList
          .where((seeker) {
        bool matched = selectedGenders.contains(seeker.gender?.toLowerCase());
        if (matched) {
          print("✅ Matched gender: '${seeker.gender}' for seeker '${seeker.user?.firstName}'");
        } else {
          print("❌ No match for gender: '${seeker.gender}' not in '$selectedGenders'");
        }
        return matched;
      })
          .toList();
    }

    // Apply age range filter
    String? minAgeStr = _currentFilters['minAge'];
    String? maxAgeStr = _currentFilters['maxAge'];

    if (minAgeStr != null || maxAgeStr != null) {
      int minVal = minAgeStr != null ? int.tryParse(minAgeStr) ?? 0 : 0;
      int maxVal = maxAgeStr != null ? int.tryParse(maxAgeStr) ?? 150 : 150;

      print("### DEBUG: Applying Age Range Filter ###");
      print("Min age: $minVal | Max age: $maxVal");

      filteredList = filteredList
          .where((seeker) {
        int age = calculateAge(seeker.dob);
        bool matched = age >= minVal && age <= maxVal;

        if (matched) {
          print("✅ Matched age: $age for seeker '${seeker.user?.firstName}'");
        } else {
          print("❌ No match for age: $age not between [$minVal - $maxVal]");
        }

        return matched;
      })
          .toList();
    }

    emit(SeekerLoaded(seekers: filteredList));
  }
  // Getters for current filter selections (for UI to pre-populate bottom sheets)
  Set<int> get selectedLocationIndices => _currentFilters['location'];
  Set<int> get selectedIndustryIndices => _currentFilters['industry'];
  Set<int> get selectedCareerLevelIndices => _currentFilters['careerLevel'];
  Set<int> get selectedEmploymentStatusIndices => _currentFilters['employmentStatus'];
  Set<int> get selectedGenderIndices => _currentFilters['gender'];
  String? get minAgeFilter => _currentFilters['minAge'];
  String? get maxAgeFilter => _currentFilters['maxAge'];
}