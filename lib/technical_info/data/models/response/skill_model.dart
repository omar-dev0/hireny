class SkillModel {
  final int id;
  final String skillName;
  final String createdAt;
  final String updatedAt;
  final int user;

  SkillModel({
    required this.id,
    required this.skillName,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory SkillModel.fromJson(Map<String, dynamic> json) {
    return SkillModel(
      id: json['id'],
      skillName: json['skillName'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'skillName': skillName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
    };
  }
}
