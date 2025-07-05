class Question {
  final String? text;
  final String? type;
  final List<String?>? choices;
  final dynamic correctAnswer; // String, int, or List<bool>
  final int? optionsCount;

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
      optionsCount:
          json['optionsCount'] is String
              ? int.parse(json['optionsCount'])
              : (json['optionsCount'] ?? 0),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'type': type,
      'choices': choices,
      'correctAnswer': correctAnswer,
      'optionsCount': optionsCount,
    };
  }
}
