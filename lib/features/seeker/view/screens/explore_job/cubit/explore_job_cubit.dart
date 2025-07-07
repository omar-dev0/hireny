import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/features/auth/domain/modules/seeker/seeker.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';
import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/job_post.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'explore_job_states.dart';

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

  Future<void> getBestThree() async {
    emit(JobPostLoading());
    try {
      final result = await jobPostRepository.getThreeBestJobs();
      if (result is Success<List<JobPost>>) {
        AppSharedData.bestThreeJobs = result.response ?? [];
        emit(JobPostLoaded(jobPosts: AppSharedData.bestThreeJobs));
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
    final filteredList =
        AppSharedData.jobPosts
            .where(
              (jobPost) =>
                  jobPost.jobTitle.toLowerCase().contains(query.toLowerCase()),
            )
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
      final List<String> allLocations = [
        "Afghanistan",
        "Albania",
        "Algeria",
        "Angola",
        "Andorra",
        "Argentina",
        "Aruba",
        "Austria",
        "Azerbaijan",
        "Australia",
        "Bahamas",
        "Bahrain",
        "Bangladesh",
        "Barbados",
        "Belarus",
        "Belgium",
        "Belize",
        "Bermuda",
        "Bolivia",
        "Botswana",
        "Brazil",
        "British Indian Ocean Territory",
        "Brunei Darussalam",
        "Bulgaria",
        "Burkina Faso",
        "Cambodia",
        "Cameroon",
        "Canada",
        "Cayman Islands",
        "Chile",
        "China",
        "Colombia",
        "Costa Rica",
        "Cyprus",
        "Czech",
        "Denmark",
        "Dominica",
        "Dominican",
        "Ecuador",
        "Egypt",
        "Estonia",
        "Ethiopia",
        "Fiji",
        "Finland",
        "France",
        "Gambia",
        "Ghana",
        "Gibraltar",
        "Grenada",
        "Guam",
        "Guatemala",
        "Guernsey",
        "Guyana",
        "Haiti",
        "Honduras",
        "Greece",
        "Hungary",
        "Germany",
        "Hong Kong",
        "Iceland",
        "Iran",
        "Iraq",
        "Indonesia",
        "Israel",
        "Jersey",
        "Jordan",
        "Japan",
        "Kazakhstan",
        "Jamaica",
        "Korea",
        "Italy",
        "Lebanon",
        "Lesotho",
        "Liberia",
        "Lithuania",
        "Luxembourg",
        "Kuwait",
        "Kenya",
        "Macau",
        "Macedonia",
        "Malawi",
        "Malaysia",
        "India",
        "Maldives",
        "Moldova",
        "Monaco",
        "Mauritius",
        "Malta",
        "Mozambique",
        "Morocco",
        "Myanmar",
        "Namibia",
        "Mexico",
        "Nepal",
        "Northern Mariana Islands",
        "Norway",
        "Oman",
        "Nigeria",
        "New Zealand",
        "Palestinian Territories",
        "Panama",
        "Peru",
        "Papua New Guinea",
        "Zimbabwe",
        "Zambia",
        "Virgin Islands",
        "Venezuela",
        "Viet Nam",
        "Portugal",
        "Puerto Rico",
        "Poland",
        "Qatar",
        "Netherlands",
        "Pakistan",
        "Uzbekistan",
        "Uruguay",
        "Ukraine",
        "Uganda",
        "Philippines",
        "Rwanda",
        "Turks And Caicos Islands",
        "Tunisia",
        "Tanzania",
        "Russia",
        "Trinidad And Tobago",
        "Romania",
        "Taiwan",
        "Turkey",
        "Thailand",
        "Saint Kitts And Nevis",
        "Saint Lucia",
        "Senegal",
        "Seychelles",
        "Slovakia",
        "Slovenia",
        "Somalia",
        "Swaziland",
        "Syrian Arab",
        "Sri Lanka",
        "Sweden",
        "United Arab Emirates",
        "Spain",
        "Switzerland",
        "Saudi Arabia",
        "Singapore",
        "United Kingdom",
        "South Africa",
        "United States",
      ];

      final List<String> selectedLocations =
          selectedLocationIndices
              .map((i) => allLocations[i].toLowerCase())
              .toList();

      print("### DEBUG: Applying Location Filter ###");
      print("Selected indices: $selectedLocationIndices");
      print("All locations: $allLocations");
      print("Selected locations: $selectedLocations");

      filteredList =
          filteredList.where((jobPost) {
            bool matched = selectedLocations.contains(
              jobPost.country?.toLowerCase() ?? '',
            );
            if (matched) {
              print(
                "✅ Matched location: '${jobPost.country}' for job '${jobPost.jobTitle}'",
              );
            } else {
              print(
                "❌ No match for location: '${jobPost.country}' not in '$selectedLocations'",
              );
            }
            return matched;
          }).toList();
    }

    // Apply category filter
    Set<int> selectedCategoryIndices = _currentFilters['category'];
    if (selectedCategoryIndices.isNotEmpty) {
      final List<String> allCategories = [
        "Agriculture",
        "Automotive",
        "Banking",
        "Construction",
        "Consumer Goods",
        "Education",
        "Energy & Utilities",
        "Entertainment",
        "Environmental Services",
        "Fashion & Apparel",
        "Food & Beverage",
        "Government",
        "Healthcare",
        "Hospitality & Tourism",
        "Information Technology",
        "Insurance",
        "Legal Services",
        "Logistics & Transportation",
        "Manufacturing",
        "Media & Communications",
        "Mining",
        "Nonprofit",
        "Pharmaceuticals",
        "Real Estate",
        "Retail",
        "Software Development",
        "Telecommunications",
        "Textiles",
        "Waste Management",
        "Wholesale & Distribution",
      ];
      final List<String> selectedCategories =
          selectedCategoryIndices
              .map((i) => allCategories[i].toLowerCase())
              .toList();

      print("### DEBUG: Applying Category Filter ###");
      print("Selected indices: $selectedCategoryIndices");
      print("All categories: $allCategories");
      print("Selected categories: $selectedCategories");

      filteredList =
          filteredList.where((jobPost) {
            bool matched = jobPost.category.any(
              (cat) => selectedCategories.contains(cat.toLowerCase()),
            );
            if (matched) {
              print(
                "✅ Matched category: '${jobPost.category}' for job '${jobPost.jobTitle}'",
              );
            } else {
              print(
                "❌ No match for category: '${jobPost.category}' not in '$selectedCategories'",
              );
            }
            return matched;
          }).toList();
    }

    // Apply job type filter
    Set<int> selectedJobTypeIndices = _currentFilters['jobType'];
    if (selectedJobTypeIndices.isNotEmpty) {
      final List<String> allJobTypes = AppSharedData.jobTitle;
      final List<String> selectedJobTypes =
          selectedJobTypeIndices
              .map((i) => allJobTypes[i].toLowerCase())
              .toList();

      print("### DEBUG: Applying Job Type Filter ###");
      print("Selected indices: $selectedJobTypeIndices");
      print("All job types: $allJobTypes");
      print("Selected job types: $selectedJobTypes");

      filteredList =
          filteredList.where((jobPost) {
            bool matched = selectedJobTypes.contains(
              jobPost.jobType?.toLowerCase() ?? '',
            );
            if (matched) {
              print(
                "✅ Matched job type: '${jobPost.jobType}' for job '${jobPost.jobTitle}'",
              );
            } else {
              print(
                "❌ No match for job type: '${jobPost.jobType}' not in '$selectedJobTypes'",
              );
            }
            return matched;
          }).toList();
    }

    // Apply job location type filter
    Set<int> selectedJobLocationIndices = _currentFilters['jobLocationType'];
    if (selectedJobLocationIndices.isNotEmpty) {
      final List<String> allJobLocationTypes = AppSharedData.jobLocationTypes;
      final List<String> selectedJobLocationTypes =
          selectedJobLocationIndices
              .map((i) => allJobLocationTypes[i].toLowerCase())
              .toList();

      print("### DEBUG: Applying Job Location Type Filter ###");
      print("Selected indices: $selectedJobLocationIndices");
      print("All job location types: $allJobLocationTypes");
      print("Selected job location types: $selectedJobLocationTypes");

      filteredList =
          filteredList.where((jobPost) {
            bool matched = selectedJobLocationTypes.contains(
              jobPost.jobLocationType?.toLowerCase() ?? '',
            );
            if (matched) {
              print(
                "✅ Matched job location type: '${jobPost.jobLocationType}' for job '${jobPost.jobTitle}'",
              );
            } else {
              print(
                "❌ No match for job location type: '${jobPost.jobLocationType}' not in '$selectedJobLocationTypes'",
              );
            }
            return matched;
          }).toList();
    }

    // Remaining filters are untouched...

    // Apply experience level filter
    Set<int> selectedExperienceLevelIndices =
        _currentFilters['experienceLevel'];
    if (selectedExperienceLevelIndices.isNotEmpty) {
      final List<String> allExperienceLevels = AppSharedData.careerLevels;
      final List<String> selectedExperienceLevels =
          selectedExperienceLevelIndices
              .map((i) => allExperienceLevels[i])
              .toList();
      filteredList =
          filteredList
              .where(
                (jobPost) => selectedExperienceLevels.contains(
                  jobPost.educationLevel.toLowerCase(),
                ),
              )
              .toList();
    }

    // Apply date filter
    String selectedDate = _currentFilters['date'];
    if (selectedDate != 'All') {
      filteredList =
          filteredList
              .where((j) => _isWithinDateRange(j.createdAt, selectedDate))
              .toList();
    }

    // Apply salary range filter
    String? minSalaryStr = _currentFilters['salaryMin'];
    String? maxSalaryStr = _currentFilters['salaryMax'];
    if (minSalaryStr != null || maxSalaryStr != null) {
      double minSalary =
          minSalaryStr != null ? double.tryParse(minSalaryStr) ?? 0.0 : 0.0;
      double maxSalary =
          maxSalaryStr != null
              ? double.tryParse(maxSalaryStr) ?? double.infinity
              : double.infinity;
      filteredList =
          filteredList.where((jobPost) {
            final salary =
                double.tryParse(
                  jobPost.maxSalary.replaceAll('LE', '').trim(),
                ) ??
                0.0;
            return salary >= minSalary && salary <= maxSalary;
          }).toList();
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
  Set<int> get selectedExperienceLevelIndices =>
      _currentFilters['experienceLevel'];
  String get selectedDateFilter => _currentFilters['date'];
  String? get minSalaryFilter => _currentFilters['salaryMin'];
  String? get maxSalaryFilter => _currentFilters['salaryMax'];
}
