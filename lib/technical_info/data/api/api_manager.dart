import 'package:dio/dio.dart';
import 'package:hireny/result.dart';
import 'package:hireny/technical_info/data/api/url_constants.dart';
import 'package:hireny/technical_info/data/models/response/tech_info_respnonse.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import 'package:injectable/injectable.dart';

import '../models/response/certificate_model.dart';
import '../models/response/course_model.dart';
import '../models/response/education_model.dart';
import '../models/response/experience_model.dart';
import '../models/response/lang_model.dart';
import '../models/response/skill_model.dart';

@singleton
@injectable

class TechApiManager {
  final Dio _dio;

  String? token ="eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxMTYyNjM0LCJpYXQiOjE3NTExMTk0MzQsImp0aSI6ImM4MTlmZTk3MzY2YTRiZDFhMjUxMzk1MTNkMjNlYmJhIiwidXNlcl9pZCI6MjksImlkIjoyOSwiZmlyc3ROYW1lIjoidGVzdCIsImxhc3ROYW1lIjoidGVzdCIsImVtYWlsIjoiZmx1dHRlclRlc3QxMjNAZ21haWwuY29tIiwicm9sZSI6InNlZWtlciIsInBob3RvIjoiL21lZGlhL3Bob3Rvcy9kZWZhdWx0LnBuZyJ9.nuLv7o_OPQxKm0cT2EXahVkWpxx4ocYb22eYdUGsYTw";
  List<String> deleteApi = [
    "",
    UrlConstants.deleteCourse,
    UrlConstants.deleteCertificate,
    UrlConstants.deleteEdu,
    UrlConstants.deleteExperience,
  ];
  List<String> addApi = [
    "",
    UrlConstants.addCourse,
    UrlConstants.addCertificate,
    UrlConstants.addEdu,
    UrlConstants.addExperience,
  ];
  List<String> updateApi = [
    "",
    UrlConstants.updateCourse,
    UrlConstants.updateCertificate,
    UrlConstants.updateEdu,
    UrlConstants.updateExperience,
  ];

  TechApiManager(this._dio);

  @PostConstruct()
  Future<void> init() async {
    await getConstants();
  }
  /// get constants
  Future<void> getConstants() async {
    final skillsResponse = await _dio.get(
      UrlConstants.getSkills,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    final jobsResponse = await _dio.get(
      UrlConstants.getJobs,
      options: Options(headers: {'Authorization': 'Bearer $token'}),
    );

    AppSharedData.skills = List<String>.from(skillsResponse.data);
    AppSharedData.jobs = List<String>.from(jobsResponse.data);
  }

 /// get
  Future<Result<TechInfoResponse>> getTechInfo(String token) async {
    try {
      if ((AppSharedData.techInfo?.isEmpty ?? true)) {
        final response = await _dio.get(
          UrlConstants.getTechInfo,
          options: Options(headers: {'Authorization': 'Bearer $token'}),
        );

        if (response.statusCode == 200 || response.statusCode == 201) {
          final data = response.data;
          if (data != null) {
            final techInfo = TechInfoResponse.fromJson(data);

            AppSharedData.techInfo = {
              "educations": techInfo.educations,
              "certificates": techInfo.certificates,
              "courses": techInfo.courses,
              "experiences": techInfo.experiences,
              "languages": techInfo.languages,
              "skills": techInfo.skills,
            };

            // 🔍 Print the content of AppSharedData.techInfo
            AppSharedData.techInfo?.forEach((key, list) {
              print('🔹 $key:');
              for (var item in list) {
                print('   ➤ ${item.toJson()}'); // Assuming your models have toJson()
              }
            });

            return Success(response: techInfo);
          } else {
            return Error(error: "Invalid data format received from server.");
          }
        } else {
          return Error(error: "Failed to load tech info: ${response.statusCode}");
        }
      } else {
        return Success(response: TechInfoResponse(
          educations: (AppSharedData.techInfo?['educations'] as List).cast<Educations>(),
          certificates: (AppSharedData.techInfo?['certificates'] as List).cast<CertificateModel>(),
          courses: (AppSharedData.techInfo?['courses'] as List).cast<CourseModel>(),
          experiences: (AppSharedData.techInfo?['experiences'] as List).cast<ExperienceModel>(),
          languages: (AppSharedData.techInfo?['languages'] as List).cast<LanguageModel>(),
          skills: (AppSharedData.techInfo?['skills'] as List).cast<SkillModel>(),
        ));

      }
    } catch (e) {
      return Error(error: "Exception occurred: ${e.toString()}");
    }
  }
  /// Add
  Future<Result<void>> addTechInfo(dynamic obj, int addID) async {
    try {
      print("Sending: ${obj.toJson()}");

      final response = await _dio.post(
        addApi[addID],
        data: obj.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        AppSharedData.techInfo ??= {};

        switch (addID) {
          case 1: // Course
            AppSharedData.techInfo!['courses'] ??= <CourseModel>[];
            (AppSharedData.techInfo!['courses'] as List<CourseModel>)
                .add(CourseModel.fromJson(response.data));
            break;
          case 2: // Certificate
            AppSharedData.techInfo!['certificates'] ??= <CertificateModel>[];
            (AppSharedData.techInfo!['certificates'] as List<CertificateModel>)
                .add(CertificateModel.fromJson(response.data));
            break;
          case 3: // Education
            AppSharedData.techInfo!['educations'] ??= <Educations>[];
            (AppSharedData.techInfo!['educations'] as List<Educations>)
                .add(Educations.fromJson(response.data));
            break;
          case 4: // Experience
            AppSharedData.techInfo!['experiences'] ??= <ExperienceModel>[];
            (AppSharedData.techInfo!['experiences'] as List<ExperienceModel>)
                .add(ExperienceModel.fromJson(response.data));
            break;
          default:
            break;
        }

        return Success();
      } else {
        return Error(error: "API returned error: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Exception occurred: ${e.toString()}");
    }
  }
  /// Delete
  Future<Result<void>> deleteTechInfo(String id, int deleteID) async {
    try {
      final response = await _dio.delete(
        "${deleteApi[deleteID]}/$id/",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppSharedData.techInfo ??= {};

        switch (deleteID) {
          case 1: // Course
            final list = AppSharedData.techInfo!['courses'] as List<CourseModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 2: // Certificate
            final list = AppSharedData.techInfo!['certificates'] as List<CertificateModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 3: // Education
            final list = AppSharedData.techInfo!['educations'] as List<Educations>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 4: // Experience
            final list = AppSharedData.techInfo!['experiences'] as List<ExperienceModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
        // Add more if needed
          default:
            break;
        }

        return Success();
      } else {
        return Error(error: "Failed to delete item: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Exception deleting item: ${e.toString()}");
    }
  }
  /// update
  Future<Result<void>> updateTechInfo(String itemID, dynamic data, int updateID) async {
    try {

      final response = await _dio.put(
        "${updateApi[updateID]}/$itemID/",
        data: data.tojson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      String? key;
      dynamic updatedModel;

      if (updateApi[updateID].contains("Certificate")) {
        key = "certificates";
        updatedModel = CertificateModel.fromJson(response.data);
      } else if (updateApi[updateID].contains("Course")) {
        key = "courses";
        updatedModel = CourseModel.fromJson(response.data);
      } else if (updateApi[updateID].contains("Edu")) {
        key = "educations";
        updatedModel = Educations.fromJson(response.data);
      } else if (updateApi[updateID].contains("Experience")) {
        key = "experiences";
        updatedModel = ExperienceModel.fromJson(response.data);
      } else if (updateApi[updateID].contains("Lang")) {
        key = "languages";
        updatedModel = LanguageModel.fromJson(response.data);
      } else if (updateApi[updateID].contains("Skills")) {
        key = "skills";
        updatedModel = SkillModel.fromJson(response.data);
      }

        final list = AppSharedData.techInfo?[key];
        final index = list?.indexWhere((item) => item.id.toString() == itemID);
       list![index!] = updatedModel;
      AppSharedData.techInfo![key!] = list;
      
      if (response.statusCode == 200 || response.statusCode == 204) {
        return Success();
      } else {
        return Error(error: "Failed to update: ${response.statusCode}");
      }
    } catch (e) {
      return Error(error: "Error update : $e");
    }
  }
}
