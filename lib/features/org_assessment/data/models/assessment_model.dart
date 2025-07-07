class AssessmentResponse {
  final int id;
  final String assessmentTitle;
  final int assessmentDuration;
  final String createdAt;
  final String updatedAt;
  final List<Question> questions;
  final int organization;
  final int totalApplicants;

  AssessmentResponse({
    required this.id,
    required this.assessmentTitle,
    required this.assessmentDuration,
    required this.createdAt,
    required this.updatedAt,
    required this.questions,
    required this.organization,
    required this.totalApplicants,
  });

  factory AssessmentResponse.fromJson(Map<String, dynamic> json) {
    return AssessmentResponse(
      id: json['id'],
      assessmentTitle: json['assessmentTitle'],
      assessmentDuration: json['assessmentDuration'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      questions: List<Question>.from(json['questions'].map((x) => Question.fromJson(x))),
      organization: json['organization'],
      totalApplicants: json['total_applicants'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'assessmentTitle': assessmentTitle,
    'assessmentDuration': assessmentDuration,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    'questions': questions.map((x) => x.toJson()).toList(),
    'organization': organization,
    'total_applicants': totalApplicants,
  };
}
//===========================================================
class Question {
  final String text;
  final String type;
  final List<String> choices;
  final dynamic correctAnswer; // String, int, or List<bool>
  final int optionsCount;

  Question({
    required this.text,
    required this.type,
    required this.choices,
    required this.correctAnswer,
    required this.optionsCount,
  });

  factory Question.fromJson(Map<String, dynamic> json) {
    return Question(
      text: json['text'],
      type: json['type'],
      choices: List<String>.from(json['choices']),
      correctAnswer: json['correctAnswer'],
      optionsCount: json['optionsCount'],
    );
  }

  Map<String, dynamic> toJson() => {
    'text': text,
    'type': type,
    'choices': choices,
    'correctAnswer': correctAnswer,
    'optionsCount': optionsCount,
  };
}
