// {
// "id": 5,
// "serviceTitle": "Digital Marketing Specialist",
// "salary": "3200.00",
// "serviceDescription": "We specialize in SEO, social media marketing, and email campaigns to grow your brand online.",
// "category": [
// "Marketing",
// "Advertising"
// ],
// "country": "Egypt",
// "city": "Cairo",
// "currency": [
// "EGP"
// ],
// "serviceAvailable": "available",
// "createdAt": "2025-07-01T22:17:30.008876Z",
// "updatedAt": "2025-07-01T22:17:30.008921Z",
// "organization": 8,
// "total_applications": 0,
// "companyName": "Tech Solutions",
// "companyLogo": "/media/photos/default.png"
// }
class ServiceResponse {
  final int id;
  final String serviceTitle;
  final String salary;
  final String serviceDescription;
  final List<String> category;
  final String country;
  final String city;
  final List<String> currency;
  final String serviceAvailable;
  final String createdAt;
  final String updatedAt;
  final int organization;
  final int totalApplications;
  final String companyName;
  final String companyLogo;

  ServiceResponse({
    required this.id,
    required this.serviceTitle,
    required this.salary,
    required this.serviceDescription,
    required this.category,
    required this.country,
    required this.city,
    required this.currency,
    required this.serviceAvailable,
    required this.createdAt,
    required this.updatedAt,
    required this.organization,
    required this.totalApplications,
    required this.companyName,
    required this.companyLogo,
  });

  factory ServiceResponse.fromJson(Map<String, dynamic> json) {
    return ServiceResponse(
      id: json['id'],
      serviceTitle: json['serviceTitle'],
      salary: json['salary'],
      serviceDescription: json['serviceDescription'],
      category: List<String>.from(json['category']),
      country: json['country'],
      city: json['city'],
      currency: List<String>.from(json['currency']),
      serviceAvailable: json['serviceAvailable'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      organization: json['organization'],
      totalApplications: json['total_applications'],
      companyName: json['companyName'],
      companyLogo: json['companyLogo'],
    );
  }
}
