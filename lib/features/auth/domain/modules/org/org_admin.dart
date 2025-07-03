import 'dart:convert';

import 'package:hireny/features/auth/domain/modules/linkes/link.dart';
import 'package:hive/hive.dart';

import '../user/user.dart';

part 'org_admin.g.dart';

@HiveType(typeId: 1)
class OrgAdmin extends User {
  @HiveField(13)
  String? companyName;

  @HiveField(14)
  String? ceo;

  @HiveField(15)
  String? startYear;

  @HiveField(16)
  String? industry;

  @HiveField(17)
  String? orgSize;

  OrgAdmin({
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
    this.companyName,
    this.ceo,
    this.startYear,
    this.industry,
    this.orgSize,
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

  factory OrgAdmin.fromJson(Map<String, dynamic> json) => OrgAdmin(
    firstName: json['firstName'],
    lastName: json['lastName'],
    email: json['email'],
    phone: json['phone'],
    role: json['role'],
    country: json['country'],
    city: json['city'],
    links:
        json['links'] is String
            ? (jsonDecode(json['links']) as List?)
                ?.map((e) => UserLink.fromJson(e as Map<String, dynamic>))
                .toList()
            : (json['links'] is List
                ? (json['links'] as List)
                    .map((e) => UserLink.fromJson(e as Map<String, dynamic>))
                    .toList()
                : null),

    updatesToEmail: json['updatesToEmail'],
    photo: json['photo'],
    companyName: json['name'],
    ceo: json['ceo'],
    startYear: json['eYear'],
    industry: json['industry'],
    orgSize: json['organizationSize'],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'role': role,
      'country': country,
      'city': city,
      'links': jsonEncode(links.map((e) => e?.toJson()).toList()),
      'updatesToEmail': updatesToEmail,
      'name': companyName,
      'ceoName': ceo,
      'eYear': startYear,
      'industry': jsonEncode([industry]),
      'organizationSize': orgSize,
    };
  }
}
