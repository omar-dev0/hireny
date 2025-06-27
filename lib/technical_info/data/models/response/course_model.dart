class CourseModel {
  final int id;
  final String courseName;
  final String institutionName;
  final String dateCompleted;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int? user;

  CourseModel({
    required this.id,
    required this.courseName,
    required this.institutionName,
    required this.dateCompleted,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'],
      courseName: json['courseName'],
      institutionName: json['institutionName'],
      dateCompleted: json['dateCompleted'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'courseName': courseName,
      'institutionName': institutionName,
      'dateCompleted': dateCompleted,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
    };
  }
}
