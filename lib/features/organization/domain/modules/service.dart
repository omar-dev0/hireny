class ServiceModel {
  final int? id;
  final String? serviceTitle;
  final String? salary;
  final String? serviceDescription;
  final List<String>? category;
  final String? country;
  final String? city;
  final List<String>? currency;
  final String? serviceAvailable;
  final String? createdAt;
  final String? updatedAt;
  final int? organization;
  final int? totalApplications;
  final String? companyName;
  final String? companyLogo;

  const ServiceModel({
    this.id,
    this.serviceTitle,
    this.salary,
    this.serviceDescription,
    this.category,
    this.country,
    this.city,
    this.currency,
    this.serviceAvailable,
    this.createdAt,
    this.updatedAt,
    this.organization,
    this.totalApplications,
    this.companyName,
    this.companyLogo,
  });

  factory ServiceModel.fromJson(Map<String, dynamic> json) {
    // Parse category safely
    List<String> categories = [];
    if (json['category'] != null) {
      if (json['category'] is List<dynamic>) {
        categories = (json['category'] as List<dynamic>)
            .map((item) => item.toString())
            .toList();
      } else if (json['category'] is String) {
        categories = (json['category'] as String)
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
    }

    // Parse currency safely
    List<String> currencies = [];
    if (json['currency'] != null) {
      if (json['currency'] is List<dynamic>) {
        currencies = (json['currency'] as List<dynamic>)
            .map((item) => item.toString())
            .toList();
      } else if (json['currency'] is String) {
        currencies = (json['currency'] as String)
            .split(',')
            .map((s) => s.trim())
            .where((s) => s.isNotEmpty)
            .toList();
      }
    }

    return ServiceModel(
      id: json['id'],
      serviceTitle: json['serviceTitle']?.toString(),
      salary: json['salary']?.toString(),
      serviceDescription: json['serviceDescription']?.toString(),
      category: categories,
      country: json['country']?.toString(),
      city: json['city']?.toString(),
      currency: currencies,
      serviceAvailable: json['serviceAvailable']?.toString(),
      createdAt: json['createdAt']?.toString(),
      updatedAt: json['updatedAt']?.toString(),
      organization: json['organization'],
      totalApplications: json['total_applications'] ?? 0,
      companyName: json['companyName']?.toString(),
      companyLogo: json['companyLogo']?.toString(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'serviceTitle': serviceTitle,
      'salary': salary,
      'serviceDescription': serviceDescription,
      'category': category,
      'country': country,
      'city': city,
      'currency': currency,
      'serviceAvailable': serviceAvailable,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
      'organization': organization,
      'total_applications': totalApplications,
      'companyName': companyName,
      'companyLogo': companyLogo,
    };
  }
}