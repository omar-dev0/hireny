class ExperienceModel {
  final int id;
  final String companyName;
  final String jobTitle;
  final String fromDate;
  final String toDate;
  final String jobType;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int? user;

  ExperienceModel({
    required this.id,
    required this.companyName,
    required this.jobTitle,
    required this.fromDate,
    required this.toDate,
    required this.jobType,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory ExperienceModel.fromJson(Map<String, dynamic> json) {
    return ExperienceModel(
      id: json['id'],
      companyName: json['companyName'],
      jobTitle: json['jobTitle'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      jobType: json['jobType'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'companyName': companyName,
      'jobTitle': jobTitle,
      'fromDate': fromDate,
      'toDate': toDate,
      'jobType': jobType,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
    };
  }
}
