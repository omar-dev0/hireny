import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hireny/result.dart';
import 'package:injectable/injectable.dart';

import '../../../../../../utils/data_shared/app_shared_data.dart';
import '../../../../domain/modules/course.dart';
import '../../../../domain/repo_contract/seeker_repository.dart';
import 'course_states.dart';

@injectable
@injectable
class CourseCubit extends Cubit<CourseState> {
  final SeekerRepository courseRepository;

  CourseCubit(this.courseRepository) : super(CourseInitial());

  Map<String, dynamic> _currentFilters = {
    'category': <int>{},
    'date': 'All',
    'priceMin': null,
    'priceMax': null,
  };

  Future<void> fetchNotRegisteredCourses() async {
    emit(CourseLoading());
    try {
      final result = await courseRepository.getNotRegisteredCourses();

      if (result is Success<List<Course>>) {
        AppSharedData.courses = result.response ?? [];
        _applyFilters(); // Apply any existing filters after fetching
      } else if (result is Error<List<Course>>) {
        emit(CourseError(message: "An error occurred"));
      }
    } catch (e) {
      emit(CourseError(message: e.toString()));
    }
  }

  void filterCourses(String query) {
    if (query.isEmpty) {
      _applyFilters(); // Apply all current filters if search query is empty
      return;
    }

    final filteredList =
    AppSharedData.courses
        .where(
          (course) =>
          course.title.toLowerCase().contains(query.toLowerCase()),
    )
        .toList();

    emit(CourseLoaded(courses: filteredList));
  }

  void updateCategoryFilter(Set<int> selectedIndices) {
    _currentFilters['category'] = selectedIndices;
    _applyFilters();
  }

  void updateDateFilter(String selectedDate) {
    _currentFilters['date'] = selectedDate;
    _applyFilters();
  }

  void updatePriceRangeFilter({String? min, String? max}) {
    _currentFilters['priceMin'] = min;
    _currentFilters['priceMax'] = max;
    _applyFilters();
  }

  void _applyFilters() {
    List<Course> filteredList = List.from(AppSharedData.courses);

    // Apply category filter
    Set<int> selectedCategoryIndices = _currentFilters['category'];
    if (selectedCategoryIndices.isNotEmpty) {
      final List<String> allIndustries = AppSharedData.industries;
      final List<String> selectedCategories = selectedCategoryIndices.map((i) => allIndustries[i]).toList();
      filteredList = filteredList
          .where((course) =>
          course.category.any((cat) => selectedCategories.contains(cat.toLowerCase())))
          .toList();
    }

    // Apply date filter
    String selectedDate = _currentFilters['date'];
    if (selectedDate != 'All') {
      filteredList = filteredList
          .where((c) => _isWithinDateRange(c.createdAt, selectedDate))
          .toList();
    }

    // Apply price range filter
    String? minPriceStr = _currentFilters['priceMin'];
    String? maxPriceStr = _currentFilters['priceMax'];
    if (minPriceStr != null || maxPriceStr != null) {
      double minPrice = minPriceStr != null ? double.tryParse(minPriceStr) ?? 0.0 : 0.0;
      double maxPrice = maxPriceStr != null ? double.tryParse(maxPriceStr) ?? double.infinity : double.infinity;

      filteredList = filteredList
          .where((course) {
        final price = double.tryParse(course.price.replaceAll('LE', '').trim()) ?? 0.0;
        return price >= minPrice && price <= maxPrice;
      })
          .toList();
    }

    emit(CourseLoaded(courses: filteredList));
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
  Set<int> get selectedCategoryIndices => _currentFilters['category'];
  String get selectedDateFilter => _currentFilters['date'];
  String? get minPriceFilter => _currentFilters['priceMin'];
  String? get maxPriceFilter => _currentFilters['priceMax'];
}


