class Application {
  final int id;
  final DateTime createdAt;
  final DateTime updatedAt;
  final String status;
  final int organization;
  final ServicePost servicePost;
  final Applicant applicant;

  Application({
    required this.id,
    required this.createdAt,
    required this.updatedAt,
    required this.status,
    required this.organization,
    required this.servicePost,
    required this.applicant,
  });

  factory Application.fromJson(Map<String, dynamic> json) {
    return Application(
      id: json['id'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      status: json['status'],
      organization: json['organization'],
      servicePost: ServicePost.fromJson(json['servicePost']),
      applicant: Applicant.fromJson(json['applicant']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      'status': status,
      'organization': organization,
      'servicePost': servicePost.toJson(),
      'applicant': applicant.toJson(),
    };
  }
}

class ServicePost {
  final int id;
  final String title;
  final String company;
  final String photo;
  final double salary;
  final List<String> currency;

  ServicePost({
    required this.id,
    required this.title,
    required this.company,
    required this.photo,
    required this.salary,
    required this.currency,
  });

  factory ServicePost.fromJson(Map<String, dynamic> json) {
    return ServicePost(
      id: json['id'],
      title: json['title'],
      company: json['company'],
      photo: json['photo'],
      salary: (json['salary'] as num).toDouble(),
      currency: List<String>.from(json['currency']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'company': company,
      'photo': photo,
      'salary': salary,
      'currency': currency,
    };
  }
}

class Applicant {
  final int id;
  final String name;
  final String email;
  final String photo;
  final String phone;
  final int adminId;

  Applicant({
    required this.id,
    required this.name,
    required this.email,
    required this.photo,
    required this.phone,
    required this.adminId,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      phone: json['phone'],
      adminId: json['adminId'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'phone': phone,
      'adminId': adminId,
    };
  }
}
