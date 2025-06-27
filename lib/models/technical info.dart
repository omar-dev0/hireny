// abstract class TechnicalInfo {
//   static int _counter = 0;
//
//   final int id;
//    String title;
//    String organization;
//    String startDate;
//    String endDate;
//
//   TechnicalInfo({
//     required this.title,
//     required this.organization,
//     required this.startDate,
//     required this.endDate,
//   }):id = _counter++;
// }
//
// class ExperienceModel extends TechnicalInfo {
//   final String type;
//
//   ExperienceModel({
//     required String title,
//     required String organization,
//     required String startDate,
//     required String endDate,
//     required this.type,
//   }) : super(
//     title: title,
//     organization: organization,
//     startDate: startDate,
//     endDate: endDate,
//   );
//
//   factory ExperienceModel.fromMap(Map<String, dynamic> map) {
//     return ExperienceModel(
//       title: map['title'],
//       organization: map['organization'],
//       startDate: (map['startDate']),
//       endDate: (map['endDate']),
//       type: map['type'],
//     );
//   }
// }
//
// class EducationModel extends TechnicalInfo {
//   EducationModel({
//     required String title,
//     required String organization,
//     required String startDate,
//     required String endDate,
//   }) : super(
//     title: title,
//     organization: organization,
//     startDate: startDate,
//     endDate: endDate,
//   );
//
//   factory EducationModel.fromMap(Map<String, dynamic> map) {
//     return EducationModel(
//       title: map['title'],
//       organization: map['organization'],
//       startDate: (map['startDate']),
//       endDate: (map['endDate']),
//     );
//   }
// }
//
// class CourseModel extends TechnicalInfo {
//   CourseModel({
//     required String title,
//     required String organization,
//     required String startDate,
//     required String endDate,
//   }) : super(
//     title: title,
//     organization: organization,
//     startDate: startDate,
//     endDate: endDate,
//   );
//
//   factory CourseModel.fromMap(Map<String, dynamic> map) {
//     return CourseModel(
//       title: map['title'],
//       organization: map['organization'],
//       startDate: (map['startDate']),
//       endDate: (map['endDate']),
//     );
//   }
// }
//
// class CertificateModel {
//   final String title;
//   final String organization;
//   final String dateIssued;
//   final String? link;
//
//   CertificateModel({
//     required this.title,
//     required this.organization,
//     required this.dateIssued,
//     this.link,
//   });
//
//   factory CertificateModel.fromMap(Map<String, dynamic> map) {
//     return CertificateModel(
//       title: map['title'],
//       organization: map['organization'],
//       dateIssued: (map['dateIssued']),
//       link: map['link'],
//     );
//   }
// }
//
//
//
//
