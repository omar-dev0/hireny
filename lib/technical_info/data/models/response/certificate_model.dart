class CertificateModel {
  final int id;
  final String certificateName;
  final String institutionName;
  final String dateIssued;
  final String description;
  final String createdAt;
  final String updatedAt;

  CertificateModel({
    required this.id,
    required this.certificateName,
    required this.institutionName,
    required this.dateIssued,
    required this.description,
    required this.createdAt,
    required this.updatedAt,
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
