import '../linkes/link.dart';
import 'autofill.dart';

class AutoFillOrg extends AutoFill {
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
      name: json['name'],
      phone: json['phone'],
      email: json['email'],
      country: json['country'],
      city: json['city'],
      ceoName: json['ceoName'],
      eYear: json['eYear'],
      industry: (json['industry'] as List?)?.map((e) => e.toString()).toList(),
      organizationSize: json['organizationSize'],
      links: (json['links'] as List?)
          ?.map((e) => UserLink.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'phone': phone,
      'email': email,
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
