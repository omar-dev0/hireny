// class GetServicesResponse {
//   final int id;
//   final String serviceTitle;
//   final String salary;
//   final String serviceDescription;
//   final List<String> category;
//   final String country;
//   final String city;
//   final List<String> currency;
//   final String serviceAvailable;
//   final DateTime createdAt;
//   final DateTime updatedAt;
//   final int organization;
//   final int totalApplications;
//   final String companyName;
//   final String companyLogo;
//
//   GetServicesResponse({
//     required this.id,
//     required this.serviceTitle,
//     required this.salary,
//     required this.serviceDescription,
//     required this.category,
//     required this.country,
//     required this.city,
//     required this.currency,
//     required this.serviceAvailable,
//     required this.createdAt,
//     required this.updatedAt,
//     required this.organization,
//     required this.totalApplications,
//     required this.companyName,
//     required this.companyLogo,
//   });
//
//   factory GetServicesResponse.fromJson(Map<String, dynamic> json) {
//     return GetServicesResponse(
//       id: json['id'],
//       serviceTitle: json['serviceTitle'],
//       salary: json['salary'],
//       serviceDescription: json['serviceDescription'],
//       category: List<String>.from(json['category']),
//       country: json['country'],
//       city: json['city'],
//       currency: List<String>.from(json['currency']),
//       serviceAvailable: json['serviceAvailable'],
//       createdAt: DateTime.parse(json['createdAt']),
//       updatedAt: DateTime.parse(json['updatedAt']),
//       organization: json['organization'],
//       totalApplications: json['total_applications'],
//       companyName: json['companyName'],
//       companyLogo: json['companyLogo'],
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'serviceTitle': serviceTitle,
//       'salary': salary,
//       'serviceDescription': serviceDescription,
//       'category': category,
//       'country': country,
//       'city': city,
//       'currency': currency,
//       'serviceAvailable': serviceAvailable,
//       'createdAt': createdAt.toIso8601String(),
//       'updatedAt': updatedAt.toIso8601String(),
//       'organization': organization,
//       'total_applications': totalApplications,
//       'companyName': companyName,
//       'companyLogo': companyLogo,
//     };
//   }
// }
