import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:hireny/features/org_assessment/data/api/assessment_api_const.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../../../result.dart';
import '../models/assessment_model.dart';

class OrgAssessmentApi {
  final Dio _dio;
  @factoryMethod
  OrgAssessmentApi(this._dio);


  /// Get assessment by ID
  Future<Result<void>> getAssessments() async {
    try {
      final response = await _dio.get(
        AssessmentApiConst.getAssessments,
        options: Options(
          headers: {
            'Content-Type': 'application/json',
          },
        ),
      );

      if (response.statusCode == 200 || response.statusCode == 201) {
        final data = response.data;

        // Ensure the response is either a list or a single object
        List<AssessmentResponse> assessments = [];
        if (data is List) {
          assessments = data
              .map<AssessmentResponse>(
                  (json) => AssessmentResponse.fromJson(json))
              .toList();
        } else if (data is Map<String, dynamic>) {
          assessments = [AssessmentResponse.fromJson(data)];
        }

        AppSharedData.assessmentsOrg.addAll(assessments);
        debugPrint("Assessments fetched: ${assessments.length}");
        return Success(response: assessments);
      } else {
        return Error(
            error:
            "Failed to fetch assessments. Status code: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error fetching assessments: $e");
    }
  }
}
