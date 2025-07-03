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
  String? token =
      'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ0b2tlbl90eXBlIjoiYWNjZXNzIiwiZXhwIjoxNzUxMzU0NzgwLCJpYXQiOjE3NTEzMTE1ODAsImp0aSI6ImQyN2FkNDliYmFhMDRlNDQ5ZTNlNTgxN2JlOTUwNmM1IiwidXNlcl9pZCI6MiwiaWQiOjIsImZpcnN0TmFtZSI6InRlc3QiLCJsYXN0TmFtZSI6InRlc3QiLCJlbWFpbCI6ImZsdXR0ZXJUZXN0MTIzQGdtYWlsLmNvbSIsInJvbGUiOiJzZWVrZXIiLCJwaG90byI6Ii9tZWRpYS9waG90b3MvZGVmYXVsdC5wbmcifQ.uuOfsMb5p3_QsaRkRZD1epllckH-1Uaauwc-bylIZVY';
  List<String> deleteApi = [
    "",
    UrlConstants.deleteCourse,
    UrlConstants.deleteCertificate,
    UrlConstants.deleteEdu,
    UrlConstants.deleteExperience,
    UrlConstants.deleteSkill,
    UrlConstants.deleteLang,
  ];
  List<String> addApi = [
    "",
    UrlConstants.addCourse,
    UrlConstants.addCertificate,
    UrlConstants.addEdu,
    UrlConstants.addExperience,
    UrlConstants.addSkill,
    UrlConstants.addLang,
  ];
  List<String> updateApi = [
    "",
    UrlConstants.updateCourse,
    UrlConstants.updateCertificate,
    UrlConstants.updateEdu,
    UrlConstants.updateExperience,
  ];

  TechApiManager(this._dio);

  /// get
  Future<Result<TechInfoResponse>> getTechInfo(String token) async {
    try {
      if (!AppSharedData.calling) {
        AppSharedData.calling = true;
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
              "lang": techInfo.languages,
              "skills": techInfo.skills,
            };

            return Success(response: techInfo);
          } else {
            return Error(error: "Invalid data format received from server.");
          }
        } else {
          return Error(
            error: "Failed to load tech info: ${response.statusCode}",
          );
        }
      } else {
        return Success(
          response: TechInfoResponse(
            educations:
                (AppSharedData.techInfo?['educations'] as List)
                    .cast<Educations>(),
            certificates:
                (AppSharedData.techInfo?['certificates'] as List)
                    .cast<CertificateModel>(),
            courses:
                (AppSharedData.techInfo?['courses'] as List)
                    .cast<CourseModel>(),
            experiences:
                (AppSharedData.techInfo?['experiences'] as List)
                    .cast<ExperienceModel>(),
            languages:
                (AppSharedData.techInfo?['lang'] as List).cast<LanguageModel>(),
            skills:
                (AppSharedData.techInfo?['skills'] as List).cast<SkillModel>(),
          ),
        );
      }
    } catch (e) {
      return Error(error: "Exception occurred: ${e.toString()}");
    }
  }

  /// Add
  Future<Result<void>> addTechInfo(dynamic obj, int addID) async {
    try {
      print(obj);
      var response = await _dio.post(
        addApi[addID],
        data: obj.toJson(),
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );
      print("Sending: ${obj.toJson()}");

      if (obj is SkillModel) {
        response = await _dio.post(
          addApi.last,
          data: {'skillName': obj.skillName},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          AppSharedData.techInfo?['skills'] ??= [];
          AppSharedData.techInfo!['skills']?.add(
            SkillModel.fromJson(response.data),
          );
          return Success();
        }
      } else if (obj is LanguageModel) {
        response = await _dio.post(
          addApi.last,
          data: {'languageName': obj.languageName},
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
        if (response.statusCode == 200 || response.statusCode == 201) {
          AppSharedData.techInfo?['lang'] ??= [];
          AppSharedData.techInfo!['lang']?.add(
            LanguageModel.fromJson(response.data),
          );
          return Success();
        }
      } else {
        response = await _dio.post(
          addApi[addID],
          data: obj.toJson(),
          options: Options(
            headers: {
              'Authorization': 'Bearer $token',
              'Content-Type': 'application/json',
            },
          ),
        );
      }

      print("Response status: ${response.statusCode}");
      print("Response data: ${response.data}");

      if (response.statusCode == 200 || response.statusCode == 201) {
        switch (addID) {
          case 1:
            AppSharedData.techInfo!['courses'] ??= <CourseModel>[];
            (AppSharedData.techInfo!['courses'] as List<CourseModel>).add(
              CourseModel.fromJson(response.data),
            );
            break;
          case 2:
            AppSharedData.techInfo!['certificates'] ??= <CertificateModel>[];
            (AppSharedData.techInfo!['certificates'] as List<CertificateModel>)
                .add(CertificateModel.fromJson(response.data));
            break;
          case 3:
            AppSharedData.techInfo!['educations'] ??= <Educations>[];
            (AppSharedData.techInfo!['educations'] as List<Educations>).add(
              Educations.fromJson(response.data),
            );
            break;
          case 4:
            AppSharedData.techInfo!['experiences'] ??= <ExperienceModel>[];
            (AppSharedData.techInfo!['experiences'] as List<ExperienceModel>)
                .add(ExperienceModel.fromJson(response.data));
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
      print(deleteID);
      final response = await _dio.delete(
        "${deleteApi[deleteID]}/$id/",
        options: Options(headers: {'Authorization': 'Bearer $token'}),
      );

      if (response.statusCode == 200 || response.statusCode == 204) {
        AppSharedData.techInfo ??= {};

        switch (deleteID) {
          case 1: // Course
            final list =
                AppSharedData.techInfo!['courses'] as List<CourseModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 2: // Certificate
            final list =
                AppSharedData.techInfo!['certificates']
                    as List<CertificateModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 3: // Education
            final list =
                AppSharedData.techInfo!['educations'] as List<Educations>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 4: // Experience
            final list =
                AppSharedData.techInfo!['experiences']
                    as List<ExperienceModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 5: // Skill
            final list = AppSharedData.techInfo!['skills'] as List<SkillModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;
          case 6: // Language
            final list =
                AppSharedData.techInfo!['lang'] as List<LanguageModel>?;
            list?.removeWhere((item) => item.id.toString() == id);
            break;

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
  Future<Result<void>> updateTechInfo(
    String itemID,
    dynamic data,
    int updateID,
  ) async {
    try {
      final response = await _dio.put(
        "${updateApi[updateID]}$itemID/",
        data: data,
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
            'Content-Type': 'application/json',
          },
        ),
      );

      // Step 2: Determine key and deserialize model
      String? key;
      dynamic updatedModel;
      print("update id $updateID");
      if (updateID == 2) {
        key = "certificates";
        updatedModel = CertificateModel.fromJson(response.data);
      } else if (updateID == 1) {
        key = "courses";
        updatedModel = CourseModel.fromJson(response.data);
      } else if (updateID == 3) {
        key = "educations";
        updatedModel = Educations.fromJson(response.data);
      } else if (updateID == 4) {
        key = "experiences";
        updatedModel = ExperienceModel.fromJson(response.data);
      }
      final list = AppSharedData.techInfo?[key];

      if (list == null) {
        return Error(error: "❌ No list found for key: $key");
      }

      final index = list.indexWhere((item) => item.id.toString() == itemID);
      if (index == -1) {
        return Error(error: "❌ Item with ID $itemID not found in $key");
      }

      list[index] = updatedModel;
      AppSharedData.techInfo![key!] = list;

      if (response.statusCode == 200 || response.statusCode == 204) {
        return Success();
      } else {
        return Error(error: "Failed to update: ${response.statusCode}");
      }
    } catch (e, stackTrace) {
      print("❌ Exception occurred: $e");
      print("📌 StackTrace: $stackTrace");
      return Error(error: "Error update : $e");
    }
  }
}
