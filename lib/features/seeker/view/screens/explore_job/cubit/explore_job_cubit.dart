import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/job_post.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'explore_job_states.dart';

@injectable
@injectable
class JobPostCubit extends Cubit<JobPostState> {
  final SeekerRepository jobPostRepository;

  JobPostCubit(this.jobPostRepository) : super(JobPostInitial());

  Map<String, dynamic> _currentFilters = {
    'location': <int>{},
    'category': <int>{},
    'jobType': <int>{},
    'jobLocationType': <int>{},
    'experienceLevel': <int>{},
    'date': 'All',
    'salaryMin': null,
    'salaryMax': null,
  };

  Future<void> fetchNotAppliedJobPosts() async {
    emit(JobPostLoading());
    try {
      final result = await jobPostRepository.getNotAppliedJobPosts();

      if (result is Success<List<JobPost>>) {
        AppSharedData.jobPosts = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<JobPost>>) {
        emit(JobPostError(message: result.error ?? "An error occurred"));
      }
    } catch (e) {
      emit(JobPostError(message: e.toString()));
    }
  }

  void filterJobPosts(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList = AppSharedData.jobPosts
        .where((jobPost) =>
        jobPost.jobTitle.toLowerCase().contains(query.toLowerCase()))
        .toList();

    emit(JobPostLoaded(jobPosts: filteredList));
  }

  void updateLocationFilter(Set<int> selectedIndices) {
    _currentFilters['location'] = selectedIndices;
    _applyFilters();
  }

  void updateCategoryFilter(Set<int> selectedIndices) {
    _currentFilters['category'] = selectedIndices;
    _applyFilters();
  }

  void updateJobTypeFilter(Set<int> selectedIndices) {
    _currentFilters['jobType'] = selectedIndices;
    _applyFilters();
  }

  void updateJobLocationFilter(Set<int> selectedIndices) {
    _currentFilters['jobLocationType'] = selectedIndices;
    _applyFilters();
  }

  void updateExperienceLevelFilter(Set<int> selectedIndices) {
    _currentFilters['experienceLevel'] = selectedIndices;
    _applyFilters();
  }

  void updateDateFilter(String selectedDate) {
    _currentFilters['date'] = selectedDate;
    _applyFilters();
  }

  void updateSalaryRangeFilter({String? min, String? max}) {
    _currentFilters['salaryMin'] = min;
    _currentFilters['salaryMax'] = max;
    _applyFilters();
  }

  void _applyFilters() {
    List<JobPost> filteredList = List.from(AppSharedData.jobPosts);

    // Apply location filter
    Set<int> selectedLocationIndices = _currentFilters['location'];
    if (selectedLocationIndices.isNotEmpty) {
      final List<String> allLocations = AppSharedData.countries;
      final List<String> selectedLocations = selectedLocationIndices.map((i) => allLocations[i]).toList();
      filteredList = filteredList
          .where((jobPost) =>
          selectedLocations.contains(jobPost.country.toLowerCase()))
          .toList();
    }

    // Apply category filter
    Set<int> selectedCategoryIndices = _currentFilters['category'];
    if (selectedCategoryIndices.isNotEmpty) {
      final List<String> allCategories = AppSharedData.industries;
      final List<String> selectedCategories = selectedCategoryIndices.map((i) => allCategories[i].toLowerCase()).toList();
      filteredList = filteredList
          .where((jobPost) =>
          jobPost.category.any((cat) => selectedCategories.contains(cat.toLowerCase())))
          .toList();
    }


    // Apply job type filter
    Set<int> selectedJobTypeIndices = _currentFilters['jobType'];
    if (selectedJobTypeIndices.isNotEmpty) {
      final List<String> allJobTypes = AppSharedData.employmentStatus;
      final List<String> selectedJobTypes = selectedJobTypeIndices.map((i) => allJobTypes[i]).toList();
      filteredList = filteredList
          .where((jobPost) =>
          selectedJobTypes.contains(jobPost.jobType.toLowerCase()))
          .toList();
    }

    // Apply job location type filter
    Set<int> selectedJobLocationIndices = _currentFilters['jobLocationType'];
    if (selectedJobLocationIndices.isNotEmpty) {
      final List<String> allJobLocationTypes = AppSharedData.jobLocationTypes;
      final List<String> selectedJobLocationTypes = selectedJobLocationIndices.map((i) => allJobLocationTypes[i]).toList();
      filteredList = filteredList
          .where((jobPost) =>
          selectedJobLocationTypes.contains(jobPost.country.toLowerCase()))
          .toList();
    }

    // Apply experience level filter
    Set<int> selectedExperienceLevelIndices = _currentFilters['experienceLevel'];
    if (selectedExperienceLevelIndices.isNotEmpty) {
      final List<String> allExperienceLevels = AppSharedData.careerLevels;
      final List<String> selectedExperienceLevels = selectedExperienceLevelIndices.map((i) => allExperienceLevels[i]).toList();
      filteredList = filteredList
          .where((jobPost) =>
          selectedExperienceLevels.contains(jobPost.educationLevel.toLowerCase()))
          .toList();
    }

    // Apply date filter
    String selectedDate = _currentFilters['date'];
    if (selectedDate != 'All') {
      filteredList = filteredList
          .where((j) => _isWithinDateRange(j.createdAt, selectedDate))
          .toList();
    }

    // Apply salary range filter
    String? minSalaryStr = _currentFilters['salaryMin'];
    String? maxSalaryStr = _currentFilters['salaryMax'];
    if (minSalaryStr != null || maxSalaryStr != null) {
      double minSalary = minSalaryStr != null ? double.tryParse(minSalaryStr) ?? 0.0 : 0.0;
      double maxSalary = maxSalaryStr != null ? double.tryParse(maxSalaryStr) ?? double.infinity : double.infinity;

      filteredList = filteredList
          .where((jobPost) {
        final salary = double.tryParse(jobPost.maxSalary.replaceAll('LE', '').trim()) ?? 0.0; // Assuming salary is a string like '1000 LE'
        return salary >= minSalary && salary <= maxSalary;
      })
          .toList();
    }

    emit(JobPostLoaded(jobPosts: filteredList));
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
  Set<int> get selectedCategoryIndices => _currentFilters['category'];
  Set<int> get selectedJobTypeIndices => _currentFilters['jobType'];
  Set<int> get selectedJobLocationIndices => _currentFilters['jobLocationType'];
  Set<int> get selectedExperienceLevelIndices => _currentFilters['experienceLevel'];
  String get selectedDateFilter => _currentFilters['date'];
  String? get minSalaryFilter => _currentFilters['salaryMin'];
  String? get maxSalaryFilter => _currentFilters['salaryMax'];
}


