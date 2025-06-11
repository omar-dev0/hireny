import 'dart:convert';

import 'package:hireny/features/auth/domain/modules/linkes/link.dart';
import 'package:hive/hive.dart';

import '../user/user.dart';
part 'seeker.g.dart';

@HiveType(typeId: 0)
class Seeker extends User {
  @HiveField(13)
  String? dob;

  @HiveField(14)
  String? gender;

  @HiveField(15)
  String? title;

  @HiveField(16)
  String? nationality;

  @HiveField(17)
  String? careerLevel;

  @HiveField(18)
  String? employmentStatus;

  @HiveField(19)
  String? brief;

  @HiveField(20)
  bool? immediateStart;

  @HiveField(21)
  String? cv;

  Seeker({
    String? firstName,
    String? lastName,
    String? email,
    String? phone,
    String? role,
    String? country,
    String? city,
    List<UserLink?>? links,
    bool? updatesToEmail,
    String? photo,
    this.dob,
    this.gender,
    this.title,
    this.nationality,
    this.careerLevel,
    this.employmentStatus,
    this.brief,
    this.immediateStart,
    this.cv,
  }) : super(
         firstName: firstName,
         lastName: lastName,
         email: email,
         phone: phone,
         role: role,
         country: country,
         city: city,
         links: links,
         updatesToEmail: updatesToEmail,
         photo: photo,
       );

  factory Seeker.fromJson(Map<String, dynamic> json) => Seeker(
    firstName: json['user']['firstName'],
    lastName: json['user']['lastName'],
    email: json['user']['email'],
    role: json['user']['role'],
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
    links: (json['links'] as List?)?.map((e) => UserLink.fromJson(e)).toList(),
    immediateStart: json['immediateStart'],
    updatesToEmail: json['updatesToEmail'],
  );

  @override
  Map<String, dynamic> toJson() => {
    'firstName': firstName,
    'lastName': lastName,
    'email': email,
    'phone': phone,
    'role': role,
    'country': country,
    'city': city,
    'links': jsonEncode(links.map((e) => e?.toJson()).toList()),
    'updatesToEmail': updatesToEmail,
    'dob': dob,
    'gender': gender,
    'title': title,
    'nationality': nationality,
    'careerLevel': careerLevel,
    'employmentStatus': employmentStatus,
    'brief': brief,
    'immediateStart': immediateStart,
  };
}
