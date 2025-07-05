class SeekerApplication {
  final int? id;
  final bool? hasApplication;
  final List<dynamic>? answers;
  final DateTime? createdAt;
  final DateTime? updatedAt;
  final String? status;
  final int? user;
  final JobPost? jobPost;
  final Applicant? applicant;

  SeekerApplication({
    this.id,
    this.hasApplication,
    this.answers,
    this.createdAt,
    this.updatedAt,
    this.status,
    this.user,
    this.jobPost,
    this.applicant,
  });

  factory SeekerApplication.fromJson(Map<String, dynamic> json) {
    return SeekerApplication(
      id: json['id'],
      hasApplication: json['hasApplication'],
      answers: json['answers'],
      createdAt: json['createdAt'] != null ? DateTime.tryParse(json['createdAt']) : null,
      updatedAt: json['updatedAt'] != null ? DateTime.tryParse(json['updatedAt']) : null,
      status: json['status'],
      user: json['user'],
      jobPost: json['jobPost'] != null ? JobPost.fromJson(json['jobPost']) : null,
      applicant: json['applicant'] != null ? Applicant.fromJson(json['applicant']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'hasApplication': hasApplication,
      'answers': answers,
      'createdAt': createdAt?.toIso8601String(),
      'updatedAt': updatedAt?.toIso8601String(),
      'status': status,
      'user': user,
      'jobPost': jobPost?.toJson(),
      'applicant': applicant?.toJson(),
    };
  }
}

class JobPost {
  final int? id;
  final String? title;
  final List<Question>? questions;
  final String? companyName;
  final int? companyId;
  final String? photo;
  final DateTime? deadline;

  JobPost({
    this.id,
    this.title,
    this.questions,
    this.companyName,
    this.companyId,
    this.photo,
    this.deadline,
  });

  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'],
      title: json['title'],
      questions: (json['questions'] as List?)?.map((e) => Question.fromJson(e)).toList(),
      companyName: json['companyName'],
      companyId: json['companyId'],
      photo: json['photo'],
      deadline: json['deadline'] != null ? DateTime.tryParse(json['deadline']) : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'questions': questions?.map((q) => q.toJson()).toList(),
      'companyName': companyName,
      'companyId': companyId,
      'photo': photo,
      'deadline': deadline?.toIso8601String(),
    };
  }
}

class Question {
  final String? text;
  final String? type;
  final List<String>? choices;
  final String? optionsCount;

  Question({
    this.text,
    this.type,
    this.choices,
    this.optionsCount,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      type: json['type'],
      choices: (json['choices'] as List?)?.map((e) => e.toString()).toList(),
      optionsCount: json['optionsCount'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type,
      'choices': choices,
      'optionsCount': optionsCount,
    };
  }
}

class Applicant {
  final int? id;
  final String? name;
  final String? email;
  final String? photo;
  final String? phone;
  final String? country;
  final String? city;
  final String? nationality;
  final String? gender;
  final String? employmentStatus;
  final String? experienceLevel;
  final String? dob;

  Applicant({
    this.id,
    this.name,
    this.email,
    this.photo,
    this.phone,
    this.country,
    this.city,
    this.nationality,
    this.gender,
    this.employmentStatus,
    this.experienceLevel,
    this.dob,
  });

  factory Applicant.fromJson(Map<String, dynamic> json) {
    return Applicant(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      photo: json['photo'],
      phone: json['phone'],
      country: json['country'],
      city: json['city'],
      nationality: json['nationality'],
      gender: json['gender'],
      employmentStatus: json['employmentStatus'],
      experienceLevel: json['experienceLevel'],
      dob: json['dob'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'email': email,
      'photo': photo,
      'phone': phone,
      'country': country,
      'city': city,
      'nationality': nationality,
      'gender': gender,
      'employmentStatus': employmentStatus,
      'experienceLevel': experienceLevel,
      'dob': dob,
    };
  }
}
