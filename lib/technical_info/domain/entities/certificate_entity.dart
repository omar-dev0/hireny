class CertificateEntity {
  final int id;
  final String certificateName;
  final String institutionName;
  final String dateIssued;
  final String description;

  CertificateEntity({
    required this.id,
    required this.certificateName,
    required this.institutionName,
    required this.dateIssued,
    required this.description,
  });
}
