import 'package:hireny/features/auth/domain/modules/assessment/question.dart';

class AssessmentModel {
  final num? score;
  final String? assessmentTitle;
  final num? assessmentDuration;
  final List<Question?>? questions;
  final String? status;
  final num? id;
  final String? orgName;
  final num? orgId;
  final String? orgLogo;
  final DateTime? assessmentStartTime;
  final DateTime? assessmentEndTime;

  AssessmentModel({
    this.score,
    this.assessmentTitle,
    this.assessmentDuration,
    this.questions,
    this.status,
    this.id,
    this.orgName,
    this.orgId,
    this.orgLogo,
    this.assessmentStartTime,
    this.assessmentEndTime,
  });

  factory AssessmentModel.fromJson(Map<String, dynamic> json) {
    return AssessmentModel(
      score: json['score'],
      assessmentTitle: json['assessment']['title'],
      assessmentDuration: json['assessment']['duration'],
      status: json['status'],
      assessmentStartTime:
          DateTime.parse(json['assessmentStartTime']).toLocal(),
      assessmentEndTime: DateTime.parse(json['assessmentEndTime']).toLocal(),
      id: json['id'],
      orgName: json['company']['name'],
      orgId: json['company']['id'],
      orgLogo: json['company']['photo'],
      questions:
          (json['assessment']['questions'] as List)
              .map((q) => Question.fromJson(q))
              .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': assessmentTitle,
      'duration': assessmentDuration,
      'questions': questions?.map((q) => q?.toJson()).toList(),
      'score': score,
      'status': status,
    };
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is AssessmentModel && other.id == id;
  }

  @override
  int get hashCode => id.hashCode;
}
