class Educations {
  final int id;
  final String institutionName;
  final String degree;
  final String fromDate;
  final String toDate;
  final String description;
  final String createdAt;
  final String updatedAt;
  final int user;

  Educations({
    required this.id,
    required this.institutionName,
    required this.degree,
    required this.fromDate,
    required this.toDate,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory Educations.fromJson(Map<String, dynamic> json) {
    return Educations(
      id: json['id'],
      institutionName: json['institutionName'],
      degree: json['degree'],
      fromDate: json['fromDate'],
      toDate: json['toDate'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'institutionName': institutionName,
      'degree': degree,
      'fromDate': fromDate,
      'toDate': toDate,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
    };
  }
}
