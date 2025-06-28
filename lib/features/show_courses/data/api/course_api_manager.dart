import 'package:dio/dio.dart';
import 'package:hireny/features/show_courses/data/models/seeker_courses_registered.dart';
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/api/url_constants.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';


@singleton
@injectable

class CoursesApiManager {
  final Dio _dio;
  String? token = "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxMTc0NTI5LCJpYXQiOjE3NTExMzEzMjksImp0aSI6ImRjYzMxNDUwMjNiYzRkMWFhNzY2MTFmZDkyOTgyNTAzIiwidXNlcl9pZCI6MzUsImlkIjozNSwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3QyMjBAZ21haWwuY29tIiwicm9sZSI6InNlZWtlciIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyJ9.giNCogyNdG_PhaYPIrqYNKlvgmKD7jiFKYx11NWlIE8";
  static String getRegisteredCourses = "/api/courses/get-registered-courses/";
  CoursesApiManager(this._dio);

  /// get
  Future<Result<void>> getSeekerRegisteredCourses() async {
    try {
      if ((AppSharedData.registeredCourses.isEmpty)) {
        final response = await _dio.get(
          getRegisteredCourses,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = response.data;
          if (data != null) {
            AppSharedData.registeredCourses = (response.data as List)
                .map((e) => RegisteredCourses.fromJson(e))
                .toList();

            for (var course in AppSharedData.registeredCourses) {
              print("📘 Course: ${course.title}");
              print("   ID: ${course.id}");
              print("   Description: ${course.description}");
              print("   Categories: ${course.category.join(', ')}");
              print("   Instructor: ${course.instructor}");
              print("   Price: ${course.priceType} - ${course.priceAmount} ${course.currency}");
              print("   Total Duration: ${course.totalDuration}");
              print("   Lessons:");
              for (var lesson in course.lessons) {
                print("     📗 Lesson: ${lesson.title} (${lesson.duration})");
                print("        Video: ${lesson.video}");
                print("        PDF: ${lesson.pdf}");
              }
            }

            return Success(response: null);
          } else {
            return Error(error: "Invalid data format received from server.");
          }
        } else {
          return Error(
              error: "Failed to load tech info: ${response.statusCode}");
        }
      } else {
        return Success(response: null);
      }
    } catch (e) {
      return Error(error: "Exception occurred: ${e.toString()}");
    }
  }
}