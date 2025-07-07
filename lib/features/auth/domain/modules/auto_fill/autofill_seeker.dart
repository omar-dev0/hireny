import 'autofill.dart';

class AutoFillSeeker extends AutoFill {
  final String? firstName;
  final String? lastName;
  final String? email;
  final String? phone;
  final String? dob;
  final String? gender;
  final String? title;
  final String? nationality;
  final String? careerLevel;
  final String? employmentStatus;
  final String? brief;
  final String? country;
  final String? city;

  AutoFillSeeker({
    this.firstName,
    this.lastName,
    this.email,
    this.phone,
    this.dob,
    this.gender,
    this.title,
    this.nationality,
    this.careerLevel,
    this.employmentStatus,
    this.brief,
    this.country,
    this.city,
  });

  factory AutoFillSeeker.fromJson(Map<String, dynamic> json) {
    return AutoFillSeeker(
      firstName: json['firstName'],
      lastName: json['lastName'],
      email: json['email'],
      phone: json['phone'],
      dob: json['dob'],
      gender: json['gender'],
      title: json['title'],
      nationality: json['nationality'],
      careerLevel: json['careerLevel'],
      employmentStatus: json['employmentStatus'],
      brief: json['brief'],
      country: json['country'],
      city: json['city'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'firstName': firstName,
      'lastName': lastName,
      'email': email,
      'phone': phone,
      'dob': dob,
      'gender': gender,
      'title': title,
      'nationality': nationality,
      'careerLevel': careerLevel,
      'employmentStatus': employmentStatus,
      'brief': brief,
      'country': country,
      'city': city,
    };
  }
}
