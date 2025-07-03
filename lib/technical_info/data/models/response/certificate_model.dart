import 'package:hireny/technical_info/domain/entities/certificate_entity.dart';

class CertificateModel extends CertificateEntity {
  final String createdAt;
  final String updatedAt;

  CertificateModel({
    required this.createdAt,
    required this.updatedAt,
    required super.id,
    required super.certificateName,
    required super.institutionName,
    required super.dateIssued,
    required super.description,
  });

  factory CertificateModel.fromJson(Map<String, dynamic> json) {
    return CertificateModel(
      id: json['id'],
      certificateName: json['certificateName'],
      institutionName: json['institutionName'],
      dateIssued: json['dateIssued'],
      description: json['description'],
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'certificateName': certificateName,
      'institutionName': institutionName,
      'dateIssued': dateIssued,
      'description': description,
      'created_at': createdAt,
      'updated_at': updatedAt,
    };
  }
}
