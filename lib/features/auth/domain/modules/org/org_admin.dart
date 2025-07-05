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
  num? startYear;

  @HiveField(16)
  List<String?>? industry;

  @HiveField(17)
  String? orgSize;

  OrgAdmin({
    num? id,
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
    id: id,
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
    id: json['user']?['id'],
    firstName: json['user']?['firstName'],
    lastName: json['user']?['lastName'],
    email: json['user']?['email'],
    phone: json['organization']?['phone'],
    role: json['user']?['role'],
    country: json['organization']?['country'],
    city: json['organization']?['city'],
    links:
        (json['organization']?['links'] is List)
            ? (json['organization']['links'] as List)
                .map((e) => UserLink.fromJson(e as Map<String, dynamic>))
                .toList()
            : null,
    updatesToEmail: json['organization']?['updatesToEmail'],
    photo: json['organization']?['photo'],
    companyName: json['organization']?['name'],
    ceo: json['organization']?['ceoName'],
    startYear: json['organization']?['eYear'],
    industry:
        (json['organization']?['industry'] as List?)
            ?.map((e) => e.toString())
            .toList(),
    orgSize: json['organization']?['organizationSize'],
  );

  @override
  Map<String, dynamic> toJson() {
    return {
      'id': id,
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
