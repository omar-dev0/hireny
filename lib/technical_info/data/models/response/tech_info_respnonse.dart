import 'package:hireny/technical_info/data/models/response/certificate_model.dart';
import 'package:hireny/technical_info/data/models/response/course_model.dart';
import 'package:hireny/technical_info/data/models/response/experience_model.dart';
import 'package:hireny/technical_info/data/models/response/lang_model.dart';
import 'package:hireny/technical_info/data/models/response/skill_model.dart';

import 'education_model.dart';

class TechInfoResponse {
  final List<Educations> educations;
  final List<CertificateModel> certificates;
  final List<CourseModel> courses;
  final List<ExperienceModel> experiences;
  final List<LanguageModel> languages;
  final List<SkillModel> skills;
  final dynamic cv;

  TechInfoResponse({
    required this.educations,
    required this.certificates,
    required this.courses,
    required this.experiences,
    required this.languages,
    required this.skills,
    this.cv,
  });

  factory TechInfoResponse.fromJson(Map<String, dynamic> json) {
    return TechInfoResponse(
      educations: (json['educations'] as List<dynamic>?)
          ?.map((e) => Educations.fromJson(e))
          .toList() ??
          [],
      certificates: (json['certificates'] as List<dynamic>?)
          ?.map((e) => CertificateModel.fromJson(e))
          .toList() ??
          [],
      courses: (json['courses'] as List<dynamic>?)
          ?.map((e) => CourseModel.fromJson(e))
          .toList() ??
          [],
      experiences: (json['experiences'] as List<dynamic>?)
          ?.map((e) => ExperienceModel.fromJson(e))
          .toList() ??
          [],
      languages: (json['languages'] as List<dynamic>?)
          ?.map((e) => LanguageModel.fromJson(e))
          .toList() ??
          [],
      skills: (json['skills'] as List<dynamic>?)
          ?.map((e) => SkillModel.fromJson(e))
          .toList() ??
          [],
      cv: json['cv'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'educations': educations.map((e) => e.toJson()).toList(),
      'certificates': certificates,
      'courses': courses,
      'experiences': experiences,
      'languages': languages,
      'skills': skills,
      'cv': cv,
    };
  }
}

