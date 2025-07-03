import 'dart:convert';
import '../../../auth/domain/modules/user/user.dart';

class OrgPostOrg {
  final int id;
  final String name;
  final String phone;
  final String country;
  final String city;
  final String ceoName;
  final int establishmentYear;
  final String industry;
  final String organizationSize;
  // final List<Map<String, String>> links;
  final bool updatesToEmail;
  final bool verificationStatus;
  final String photo;
  final String createdAt;
  final String updatedAt;
  final User user;
  final String? proof;

  OrgPostOrg({
    required this.id,
    required this.name,
    required this.phone,
    required this.country,
    required this.city,
    required this.ceoName,
    required this.establishmentYear,
    required this.industry,
    required this.organizationSize,
    // required this.links,
    required this.updatesToEmail,
    required this.verificationStatus,
    required this.photo,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
    this.proof,
  });

  factory OrgPostOrg.fromJson(Map<String, dynamic> data) {
    // Handle links safely
    // List<Map<String, String>> linkData = [];
    //
    // if (data['links'] != null) {
    //   if (data['links'] is String) {
    //     // It's a raw JSON string → decode it
    //     try {
    //       final linksJson = data['links'] as String;
    //       final decoded = json.decode(linksJson) as List;
    //
    //       linkData = decoded.map((item) => item as Map<String, String>).toList();
    //     } catch (e) {
    //       linkData = [];
    //     }
    //   } else if (data['links'] is List) {
    //     // Already parsed by Dio → just cast
    //     linkData = (data['links'] as List)
    //         .map((item) => item as Map<String, String>)
    //         .toList();
    //   }
    // }

    String industryValue = '';
    if (data['industry'] != null) {
      if (data['industry'] is String) {
        industryValue = data['industry'];
      } else if (data['industry'] is List) {
        // If it's a list like ["it", "finance"]
        industryValue =
            (data['industry'] as List).map((e) => e.toString()).join(', ');
      }
    }

    // Parse user
    final userJson = data['user'] as Map<String, dynamic>? ?? {};
    final user = User.fromJson(userJson);

    return OrgPostOrg(
      id: data['id'],
      name: data['name'] ?? '',
      phone: data['phone'] ?? '',
      country: data['country'] ?? '',
      city: data['city'] ?? '',
      ceoName: data['ceoName'] ?? '',
      establishmentYear: data['eYear'] ?? 0,
      industry: industryValue,
      organizationSize: data['organizationSize'] ?? '',
      // links: linkData,
      updatesToEmail: data['updatesToEmail'] ?? false,
      verificationStatus: data['verificationStatus'] ?? false,
      photo: data['photo'] ?? '',
      createdAt: data['created_at'] ?? '',
      updatedAt: data['updated_at'] ?? '',
      user: user,
      proof: data['proof'],
    );
  }
}