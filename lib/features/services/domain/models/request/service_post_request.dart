// {
// "serviceTitle": "Digital Marketing Specialist",
// "salary": 3200.00,
// "serviceDescription": "We specialize in SEO, social media marketing, and email campaigns to grow your brand online.",
// "category": ["Marketing", "Advertising"],
// "country": ["Egypt"],
// "city": ["Giza"],
// "currency": ["EGP"],
// "serviceAvailable": "available",
// "organization": 9
// }
class ServiceRequestModel {
  final String serviceTitle;
  final double salary;
  final String serviceDescription;
  final List<String> category;
  final List<String> country;
  final List<String> city;
  final List<String> currency;
  final String serviceAvailable;
  final int? organization;

  ServiceRequestModel({
    required this.serviceTitle,
    required this.salary,
    required this.serviceDescription,
    required this.category,
    required this.country,
    required this.city,
    required this.currency,
    required this.serviceAvailable,
    required this.organization,
  });

  Map<String, dynamic> toJson() {
    return {
      "serviceTitle": serviceTitle,
      "salary": salary,
      "serviceDescription": serviceDescription,
      "category": category,
      "country": country,
      "city": city,
      "currency": currency,
      "serviceAvailable": serviceAvailable,
      "organization": organization,
    };
  }
}
