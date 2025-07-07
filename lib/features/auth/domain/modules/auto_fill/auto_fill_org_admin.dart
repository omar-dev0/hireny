import '../linkes/link.dart';
import 'autofill.dart';

class AutoFillOrg extends AutoFill {
  final String? adminFirstName;
  final String? adminLastName;
  final String? name;
  final String? phone;
  final String? email;
  final String? country;
  final String? city;
  final String? ceoName;
  final String? eYear;
  final List<String>? industry;
  final String? organizationSize;
  final List<UserLink>? links;

  AutoFillOrg({
    this.adminFirstName,
    this.adminLastName,
    this.name,
    this.phone,
    this.email,
    this.country,
    this.city,
    this.ceoName,
    this.eYear,
    this.industry,
    this.organizationSize,
    this.links,
  });

  factory AutoFillOrg.fromJson(Map<String, dynamic> json) {
    return AutoFillOrg(
      adminFirstName: json['adminFirstName'],
      adminLastName: json['adminLastName'],
      name: json['organizationName'],
      phone: json['phone'],
      email: json['organizationEmail'],
      country: json['country'],
      city: json['city'],
      ceoName: json['ceoName'],
      eYear: json['eYear']?.toString(),
      industry: (json['industry'] as List?)?.map((e) => e.toString()).toList(),
      organizationSize: json['organizationSize'],
      links: (json['links'] as List?)
          ?.map((e) => UserLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'adminFirstName': adminFirstName,
      'adminLastName': adminLastName,
      'organizationName': name,
      'phone': phone,
      'organizationEmail': email,
      'country': country,
      'city': city,
      'ceoName': ceoName,
      'eYear': eYear,
      'industry': industry,
      'organizationSize': organizationSize,
      'links': links?.map((e) => e.toJson()).toList(),
    };
  }
}
