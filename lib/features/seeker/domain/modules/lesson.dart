class Lesson {
  final int id;
  final String title;
  final String video;
  final String pdf;
  final Duration duration;
  final String createdAt;
  final String updatedAt;

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
    // Parse duration from string like "00:00:05.310000"
    Duration parseDuration(String s) {
      int hours = 0, minutes = 0;
      double seconds = 0;

      final parts = s.split(':');
      if (parts.length == 3) {
        hours = int.tryParse(parts[0]) ?? 0;
        minutes = int.tryParse(parts[1]) ?? 0;
        seconds = double.tryParse(parts[2].split('.')[0]) ?? 0.0;
      } else if (parts.length == 2) {
        minutes = int.tryParse(parts[0]) ?? 0;
        seconds = double.tryParse(parts[1].split('.')[0]) ?? 0.0;
      } else {
        seconds = double.tryParse(s.split('.')[0]) ?? 0.0;
      }

      return Duration(
        seconds: seconds.toInt(),
        minutes: minutes,
        hours: hours,
      );
    }

    return Lesson(
      id: json['id'],
      title: json['title'],
      video: json['video'] ?? '',
      pdf: json['pdf'] ?? '',
      duration: parseDuration(json['duration']),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
    );
  }
}