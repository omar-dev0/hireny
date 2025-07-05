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

  // Current filters - following the same pattern as JobPostCubit
  Map<String, dynamic> _currentFilters = {
    'category': <int>{},
    'priceMin': null,
    'priceMax': null,
  };

  ExploreServicesCubit(this.orgRepository) : super(ExploreServicesInitial());

  Future<void> fetchAllServices() async {
    emit(ExploreServicesLoading());
    try {
      final Result<List<ServiceModel>> result = await orgRepository.getNotAppliedServicePosts();

      if (result is Success<List<ServiceModel>>) {
        AppSharedData.services = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<ServiceModel>>) {
        emit(ServicesError(message: result.error ?? "An unknown error occurred"));
      }
    } catch (e) {
      emit(ServicesError(message: e.toString()));
    }
  }

  /// Filter services by title based on search query
  void filterServices(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList = AppSharedData.services
        .where((service) =>
    service.serviceTitle?.toLowerCase().contains(query.toLowerCase()) == true)
        .toList();

    emit(ServicesLoaded(services: filteredList));
  }

  void updateCategoryFilter(Set<int> selectedIndices) {
    _currentFilters['category'] = selectedIndices;
    _applyFilters();
  }

  void updatePriceRangeFilter({String? min, String? max}) {
    _currentFilters['priceMin'] = min;
    _currentFilters['priceMax'] = max;
    _applyFilters();
  }

  void _applyFilters() {
    List<ServiceModel> filteredList = List.from(AppSharedData.services);

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
      final List<String> selectedCategories = selectedCategoryIndices
          .map((i) => allCategories[i].toLowerCase())
          .toList();
      print("### DEBUG: Category Filtering Started ###");
      print("Selected category indices: $selectedCategoryIndices");
      print("All available categories: $allCategories");
      print("Selected categories (lowercase): $selectedCategories");


      filteredList = filteredList
          .where((service) {
        bool matched = service.category!
            .any((cat) {
          bool match = selectedCategories.contains(cat.toLowerCase());
          if (match) {
            print("✅ Matched category: '$cat' (from service) matches '$selectedCategories')");
          } else {
            print("❌ No match for category: '$cat' not in '$selectedCategories'");
          }
          return match;
        });
        return matched;
      })
          .toList();
    }

    // Apply price range filter
    String? minPrice = _currentFilters['priceMin'];
    String? maxPrice = _currentFilters['priceMax'];

    if (minPrice != null || maxPrice != null) {
      double minVal = minPrice != null ? double.tryParse(minPrice) ?? 0.0 : 0.0;
      double maxVal = maxPrice != null ? double.tryParse(maxPrice) ?? double.infinity : double.infinity;

      filteredList = filteredList
          .where((service) {
        double price = double.tryParse(service.salary ?? '0') ?? 0.0;
        return price >= minVal && price <= maxVal;
      })
          .toList();
    }

    emit(ServicesLoaded(services: filteredList));
  }

  // Getters for current filter selections (for UI to pre-populate bottom sheets)
  Set<int> get selectedCategoryIndices => _currentFilters['category'];
  String? get minPriceFilter => _currentFilters['priceMin'];
  String? get maxPriceFilter => _currentFilters['priceMax'];
}