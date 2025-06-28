class RegisteredCourses {
  final int id;
  final String title;
  final String description;
  final List<String> category;
  final String instructor;
  final String priceType;
  final String priceAmount;
  final String currency;
  final DateTime createdAt;
  final DateTime updatedAt;
  final List<Lesson> lessons;
  final double totalDuration;

  RegisteredCourses({
    required this.id,
    required this.title,
    required this.description,
    required this.category,
    required this.instructor,
    required this.priceType,
    required this.priceAmount,
    required this.currency,
    required this.createdAt,
    required this.updatedAt,
    required this.lessons,
    required this.totalDuration,
  });

  factory RegisteredCourses.fromJson(Map<String, dynamic> json) {
    return RegisteredCourses(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      category: List<String>.from(json['category']),
      instructor: json['instructor'],
      priceType: json['priceType'],
      priceAmount: json['priceAmount'],
      currency: json['currency'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
      lessons: (json['lessons'] as List)
          .map((e) => Lesson.fromJson(e))
          .toList(),
      totalDuration: (json['total_duration'] as num).toDouble(),
    );
  }
}

class Lesson {
  final int id;
  final String title;
  final String video;
  final String pdf;
  final String duration;
  final DateTime createdAt;
  final DateTime updatedAt;

  Lesson({
    required this.id,
    required this.title,
    required this.video,
    required this.pdf,
    required this.duration,
    required this.createdAt,
    required this.updatedAt,
  });

  factory Lesson.fromJson(Map<String, dynamic> json) {
    return Lesson(
      id: json['id'],
      title: json['title'],
      video: json['video'],
      pdf: json['pdf'],
      duration: json['duration'],
      createdAt: DateTime.parse(json['created_at']),
      updatedAt: DateTime.parse(json['updated_at']),
    );
  }
}
