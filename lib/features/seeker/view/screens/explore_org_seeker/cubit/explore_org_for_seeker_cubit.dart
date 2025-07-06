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

    print("🔍 Filtered organizations by name/job title with query: '$query'");
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
        "United States"
      ];

      final List<String> selectedLocations = selectedLocationIndices
          .map((i) => allLocations[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Location Filter ###");
      print("Selected indices: $selectedLocationIndices");
      print("All locations: $allLocations");
      print("Selected locations: $selectedLocations");

      filteredList = filteredList
          .where((orgPost) {
        bool matched =
        selectedLocations.contains(orgPost.country?.toLowerCase());
        if (matched) {
          print("✅ Matched location: '${orgPost.country}' for organization '${orgPost.name}'");
        } else {
          print("❌ No match for location: '${orgPost.country}' not in '$selectedLocations'");
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
          .where((orgPost) {
        final String postIndustry = orgPost.industry?.toLowerCase() ?? '';
        final List<String> postIndustries = postIndustry
            .split(',')
            .map((s) => s.trim())
            .toList();

        bool matched = selectedIndustries
            .any((sel) => postIndustries.contains(sel));

        if (matched) {
          print("✅ Matched industry: '${orgPost.industry}' for organization '${orgPost.name}'");
        } else {
          print("❌ No match for industry: '$postIndustries' vs '$selectedIndustries'");
        }

        return matched;
      })
          .toList();
    }

    // Apply size filter
    Set<int> selectedSizeIndices = _currentFilters['size'];
    if (selectedSizeIndices.isNotEmpty) {
      final List<String> allSizes = AppSharedData.organizationSizes;
      final List<String> selectedSizes = selectedSizeIndices
          .map((i) => allSizes[i].toLowerCase())
          .toList();

      print("### DEBUG: Applying Size Filter ###");
      print("Selected indices: $selectedSizeIndices");
      print("All sizes: $allSizes");
      print("Selected sizes: $selectedSizes");

      filteredList = filteredList
          .where((orgPost) {
        bool matched = selectedSizes
            .contains(orgPost.organizationSize?.toLowerCase());
        if (matched) {
          print("✅ Matched size: '${orgPost.organizationSize}' for organization '${orgPost.name}'");
        } else {
          print("❌ No match for size: '${orgPost.organizationSize}' not in '$selectedSizes'");
        }
        return matched;
      })
          .toList();
    }

    // Apply date filter
    String selectedDate = _currentFilters['date'];
    if (selectedDate != 'All') {
      print("### DEBUG: Applying Date Filter ###");
      print("Selected date range: $selectedDate");

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
        bool result = date.isAfter(now.subtract(Duration(hours: 1)));
        print("🕒 Checking Last Hour: $date vs ${now.subtract(Duration(hours: 1))} => $result");
        return result;
      case 'Last 24 Hours':
        bool result = date.isAfter(now.subtract(Duration(hours: 24)));
        print("🕒 Checking Last 24 Hours: $date vs ${now.subtract(Duration(hours: 24))} => $result");
        return result;
      case 'Last 7 Days':
        bool result = date.isAfter(now.subtract(Duration(days: 7)));
        print("📅 Checking Last 7 Days: $date vs ${now.subtract(Duration(days: 7))} => $result");
        return result;
      case 'Last 30 Days':
        bool result = date.isAfter(now.subtract(Duration(days: 30)));
        print("📅 Checking Last 30 Days: $date vs ${now.subtract(Duration(days: 30))} => $result");
        return result;
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