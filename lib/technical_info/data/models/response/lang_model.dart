class LanguageModel {
  final int id;
  final String languageName;
  final String createdAt;
  final String updatedAt;
  final int user;

  LanguageModel({
    required this.id,
    required this.languageName,
    required this.createdAt,
    required this.updatedAt,
    required this.user,
  });

  factory LanguageModel.fromJson(Map<String, dynamic> json) {
    return LanguageModel(
      id: json['id'],
      languageName: json['languageName'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      user: json['user'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'languageName': languageName,
      'created_at': createdAt,
      'updated_at': updatedAt,
      'user': user,
    };
  }
}
