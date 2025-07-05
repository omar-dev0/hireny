import 'dart:convert';
import 'dart:io';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';

import '../linkes/link.dart';

part 'user.g.dart';

@HiveType(typeId: 22)
class User {
  @HiveField(0)
  num? id;
  @HiveField(1)
  String? firstName;
  @HiveField(2)
  String? lastName;

  @HiveField(3)
  String? email;

  @HiveField(4)
  String? phone;

  @HiveField(5)
  String? role;

  @HiveField(6)
  String? country;

  @HiveField(7)
  String? city;

  @HiveField(8)
  List<UserLink?> links;

  @HiveField(9)
  bool? updatesToEmail;

  @HiveField(10)
  String? photo;
  @HiveField(11)
  String? accessToken;
  @HiveField(12)
  String? refreshToken;

  User({
    this.id,
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.role,
    this.country,
    this.city,
    List<UserLink?>? links,
    this.updatesToEmail,
    this.photo,
  }) : links = links ?? [];

  Map<String, dynamic> toJson() {
    // Leave empty or override in subclass
    return {};
  }

  static Future<String> encodeFileToBase64(File file) async {
    final bytes = await file.readAsBytes();
    return base64Encode(bytes);
  }

  static Future<File> decodeBase64ToFile(
    String base64Str,
    String fileName,
  ) async {
    final bytes = base64Decode(base64Str);
    final dir = await getTemporaryDirectory();
    final file = File('${dir.path}/$fileName');
    return await file.writeAsBytes(bytes);
  }

  factory User.fromJson(Map<String, dynamic> json) {
    return User(
      id: json['id'],
      firstName: json['firstName'] ?? '',
      lastName: json['lastName'] ?? '',
      email: json['email'] ?? '',
      role: json['role'] ?? '',
    );
  }
}
