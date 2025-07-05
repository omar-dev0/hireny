class Skill {
  final int? id;
  final String? skillName;
  final String? createdAt;
  final String? updatedAt;
  final int? user;

  Skill({
    this.id,
    this.skillName,
    this.createdAt,
    this.updatedAt,
    this.user,
  });

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(
      id: json['id'],
      skillName: json['skillName'] ?? '',
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