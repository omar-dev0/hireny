class JobDetailsModel {
  final int id;
  final String jobTitle;
  final String minSalary;
  final String maxSalary;
  final String jobDescription;
  final String jobRequirements;
  final bool questionForm;
  final String jobType;
  final String educationLevel;
  final String deadline;
  final String country;
  final String city;
  final List<String> category;
  final String experience;
  final String currency;
  final List<String> requiredSkills;
  final String jobLocationType;
  final List<dynamic> questions; // Can be expanded later if needed
  final String createdAt;
  final String updatedAt;
  final int organizationId;
  final int totalApplications;
  final String companyName;
  final String companyLogo;

  JobDetailsModel({
    required this.id,
    required this.jobTitle,
    required this.minSalary,
    required this.maxSalary,
    required this.jobDescription,
    required this.jobRequirements,
    required this.questionForm,
    required this.jobType,
    required this.educationLevel,
    required this.deadline,
    required this.country,
    required this.city,
    required this.category,
    required this.experience,
    required this.currency,
    required this.requiredSkills,
    required this.jobLocationType,
    required this.questions,
    required this.createdAt,
    required this.updatedAt,
    required this.organizationId,
    required this.totalApplications,
    required this.companyName,
    required this.companyLogo,
  });

  factory JobDetailsModel.fromJson(Map<String, dynamic> json) {
    // Parse category list
    List<String> categoryList = [];
    if (json['category'] is List) {
      categoryList =
          (json['category'] as List).map((item) => item.toString()).toList();
    }

    // Parse requiredSkills list
    List<String> skillsList = [];
    if (json['requiredSkills'] is List) {
      skillsList =
          (json['requiredSkills'] as List)
              .map((item) => item.toString())
              .toList();
    }

    return JobDetailsModel(
      id: json['id'],
      jobTitle: json['jobTitle'] ?? '',
      minSalary: json['minSalary'] ?? '0',
      maxSalary: json['maxSalary'] ?? '0',
      jobDescription: json['jobDescription'] ?? '',
      jobRequirements: json['jobRequirements'] ?? '',
      questionForm: json['questionForm'] ?? false,
      jobType: json['jobType'] ?? '',
      educationLevel: json['educationLevel'] ?? '',
      deadline: json['deadline'] ?? '',
      country: json['country'] ?? '',
      city: json['city'] ?? '',
      category: categoryList,
      experience: json['experience'] ?? '',
      currency: json['currency'] ?? '',
      requiredSkills: skillsList,
      jobLocationType: json['jobLocationType'] ?? '',
      questions: json['questions'] ?? [],
      createdAt: json['createdAt'] ?? '',
      updatedAt: json['updatedAt'] ?? '',
      organizationId: json['organization'] ?? -1,
      totalApplications: json['total_applications'] ?? 0,
      companyName: json['companyName'] ?? '',
      companyLogo: json['companyLogo'] ?? '',
    );
  }
}
