class JobPost {
  final int id;
  final String jobTitle;
  final String minSalary;
  final String maxSalary;
  final String jobDescription;
  final String jobRequirements;
  final String educationLevel;
  final String deadline;
  final String country;
  final String city;
  final List<String> category;
  final String currency;
  final String companyName;
  final String companyLogo;
  final int totalApplications;
  final String createdAt;
  final String jobType;
  final String jobLocationType;

  JobPost({
    required this.id,
    required this.jobTitle,
    required this.minSalary,
    required this.maxSalary,
    required this.jobDescription,
    required this.jobRequirements,
    required this.educationLevel,
    required this.deadline,
    required this.country,
    required this.city,
    required this.category,
    required this.currency,
    required this.companyName,
    required this.companyLogo,
    required this.totalApplications,
    required this.createdAt,
    required this.jobType,
    required this.jobLocationType,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    List<String> categories = [];
    if (json['category'] is List) {
      categories =
          (json['category'] as List).map((item) => item.toString()).toList();
    }

    return JobPost(
      id: json['id'],
      jobTitle: json['jobTitle'],
      minSalary: json['minSalary'] ?? 'N/A',
      maxSalary: json['maxSalary'] ?? 'N/A',
      jobDescription: json['jobDescription'] ?? '',
      jobRequirements: json['jobRequirements'] ?? '',
      educationLevel: json['educationLevel'] ?? '',
      deadline: json['deadline'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      category: categories,
      currency: json['currency'] ?? '',
      companyName: json['companyName'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
      totalApplications: json['total_applications'] ?? 0,
      createdAt: json['createdAt'] ?? '',
      jobType: json['jobType'] ?? '', // ← Add this line
      jobLocationType: json['jobLocationType'] ?? '', // ← Add this line
    );
  }
}
