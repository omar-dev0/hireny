import 'dart:convert';
import 'package:hireny/features/organization/domain/modules/skill.dart';
import 'package:hireny/utils/data_shared/app_shared_data.dart';
import '../../../auth/domain/modules/linkes/link.dart';
import '../../../auth/domain/modules/user/user.dart';

class SeekerModel {
  final int? id;
  final User? user;
  final String? phone;
  final String? dob;
  final String? gender;
  final String? title;
  final String? nationality;
  final String? careerLevel;
  final String? employmentStatus;
  final String? brief;
  final String? country;
  final String? city;
  final List<UserLink>? links;
  final bool? immediateStart;
  final bool? updatesToEmail;
  final String? cv;
  final String? photo;
  final String? createdAt;
  final String? updatedAt;
  final List<Skill>? skills;

  SeekerModel({
    this.id,
    this.user,
    this.phone,
    this.dob,
    this.gender,
    this.title,
    this.nationality,
    this.careerLevel,
    this.employmentStatus,
    this.brief,
    this.country,
    this.city,
    this.links,
    this.immediateStart,
    this.updatesToEmail,
    this.cv,
    this.photo,
    this.createdAt,
    this.updatedAt,
    this.skills,
  });

  factory SeekerModel.fromJson(Map<String, dynamic> json) {
    // Parse links
    List<UserLink> parsedLinks = [];
    if (json['links'] != null && json['links'] is String) {
      try {
        parsedLinks = UserLink.decode(json['links']);
      } catch (e) {
        parsedLinks = [];
      }
    }

    // Parse skills
    List<Skill> parsedSkills = [];
    if (json['skills'] != null && json['skills'] is List) {
      parsedSkills = (json['skills'] as List)
          .map((item) => Skill.fromJson(item))
          .toList();
    }

    return SeekerModel(
      id: json['id'],
      user: json['user'] != null ? User.fromJson(json['user']) : null,
      phone: json['phone'],
      dob: json['dob'],
      gender: json['gender'],
      title: json['title'],
      nationality: json['nationality'],
      careerLevel: json['careerLevel'],
      employmentStatus: json['employmentStatus'],
      brief: json['brief'],
      country: json['country'],
      city: json['city'],
      links: parsedLinks,
      immediateStart: json['immediateStart'] ?? false,
      updatesToEmail: json['updatesToEmail'] ?? true,
      cv: json['cv'],
      photo: json['photo'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      skills: parsedSkills,
    );
  }

}